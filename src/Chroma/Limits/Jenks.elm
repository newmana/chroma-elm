module Chroma.Limits.Jenks exposing (..)

{-| [Jenks natural breaks optimization](https://en.wikipedia.org/wiki/Jenks_natural_breaks_optimization) is a
clustering algorithm scheme for data to reduce the variance within classes and maximize the variance between classes.


# Definition

@docs limit

-}

import Array as Array
import Chroma.Limits.Analyze as Analyze
import Chroma.Limits.Matrix as Matrix
import List.Nonempty as Nonempty


type alias JenksElement =
    { index : Int
    , sum : Float
    , sumOfSquares : Float
    , variance : Float
    }


type alias JenksResult =
    { lowerClassLimits : Array.Array (Array.Array Int)
    , varianceCombinations : Array.Array (Array.Array Float)
    }


emptyJenksElement : JenksElement
emptyJenksElement =
    { index = 1
    , sum = 0.0
    , sumOfSquares = 0.0
    , variance = 0.0
    }


defaultResult : Int -> Int -> JenksResult
defaultResult bins nValues =
    { lowerClassLimits = Matrix.makeMatrix bins nValues (initLowerClassLimits bins)
    , varianceCombinations = Matrix.makeMatrix bins nValues (initVarianceCombinations bins nValues)
    }


initLowerClassLimits : Int -> Int -> Int -> Int
initLowerClassLimits bins rowIndex colIndex =
    if rowIndex == 1 && colIndex > 0 then
        1

    else
        0


initVarianceCombinations : Int -> Int -> Int -> Int -> Float
initVarianceCombinations bins nValues rowIndex colIndex =
    if rowIndex >= 2 && colIndex > 0 then
        9999999

    else
        0.0


{-| Create bins number of results using the given scale.

    Analyze.analyze (Nonempty.Nonempty 3 [1,3,4,3])
    |> limit 3
    -->  Nonempty.Nonempty 1 [3,4]

-}
limit : Int -> Analyze.Scale -> Nonempty.Nonempty Float
limit bins scale =
    let
        firstNonEmpty =
            Nonempty.Nonempty (Nonempty.get 0 scale.values) []

        lowerClassLimits =
            getMatrix bins scale |> .lowerClassLimits

        getResult bin k bounds =
            let
                nextK =
                    Matrix.getRowCol k bin lowerClassLimits |> Maybe.map (\x -> x - 1) |> Maybe.withDefault 0

                nextResult =
                    Nonempty.get nextK scale.values
            in
            ( nextK, nextResult :: bounds )

        result =
            List.foldl (\bin ( k, bounds ) -> getResult (bins - bin) k bounds) ( scale.count, [] ) (List.range 0 (bins - 1)) |> Tuple.second
    in
    case result of
        [] ->
            firstNonEmpty

        head :: tail ->
            Nonempty.Nonempty head tail


getMatrix : Int -> Analyze.Scale -> JenksResult
getMatrix bins scale =
    let
        reversedValues =
            Nonempty.foldl (::) [] scale.values

        someResult index acc =
            getData reversedValues scale.count (bins + 1) index acc
    in
    List.foldl someResult (defaultResult (scale.count + 1) (bins + 1)) (List.range 2 scale.count)


getData : List Float -> Int -> Int -> Int -> JenksResult -> JenksResult
getData values count cols row jenksResult =
    let
        ( finalJenksElement, finalJenksResult ) =
            List.foldl (step row cols) ( emptyJenksElement, jenksResult ) (List.drop (count - row) values)
    in
    { lowerClassLimits = Matrix.setRowCol row 1 1 finalJenksResult.lowerClassLimits
    , varianceCombinations = Matrix.setRowCol row 1 finalJenksElement.variance finalJenksResult.varianceCombinations
    }


step : Int -> Int -> Float -> ( JenksElement, JenksResult ) -> ( JenksElement, JenksResult )
step row cols el ( result, acc ) =
    let
        i4 =
            row - result.index

        newJenksElement =
            calculateJenksElement el result

        maybeUpdateResults =
            if i4 /= 0 then
                updateResults newJenksElement.variance

            else
                acc

        updateResults variance =
            List.foldl (\col -> updateResultForRow row col i4 variance) acc (List.range 2 (cols - 1))
    in
    ( newJenksElement, maybeUpdateResults )


calculateJenksElement : Float -> JenksElement -> JenksElement
calculateJenksElement el oldResult =
    let
        newSum =
            oldResult.sum + el

        newSumOfSquares =
            oldResult.sumOfSquares + (el * el)

        newVariance =
            newSumOfSquares - (newSum * newSum) / toFloat oldResult.index
    in
    { index = oldResult.index + 1
    , sum = newSum
    , sumOfSquares = newSumOfSquares
    , variance = newVariance
    }


updateResultForRow : Int -> Int -> Int -> Float -> JenksResult -> JenksResult
updateResultForRow row col i4 variance jenksResult =
    let
        maybeOne =
            Matrix.getRowCol row col jenksResult.varianceCombinations

        maybeTwo =
            Matrix.getRowCol i4 (col - 1) jenksResult.varianceCombinations |> Maybe.map ((+) variance)

        fstGreaterThanOrEqualToSnd =
            Maybe.map2
                (\fst snd ->
                    if fst >= snd then
                        Just snd

                    else
                        Nothing
                )
                maybeOne
                maybeTwo
    in
    case fstGreaterThanOrEqualToSnd of
        Just (Just val) ->
            { lowerClassLimits = Matrix.setRowCol row col (i4 + 1) jenksResult.lowerClassLimits
            , varianceCombinations = Matrix.setRowCol row col val jenksResult.varianceCombinations
            }

        _ ->
            jenksResult
