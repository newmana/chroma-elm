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
    { lowerClassLimits : Array.Array (Array.Array Float)
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


initLowerClassLimits : Int -> Int -> Int -> Float
initLowerClassLimits bins rowIndex colIndex =
    if rowIndex == 1 && colIndex > 0 then
        1.0

    else
        0.0


initVarianceCombinations : Int -> Int -> Int -> Int -> Float
initVarianceCombinations bins nValues rowIndex colIndex =
    if rowIndex >= 2 && colIndex > 0 then
        9999999

    else
        0.0


{-| Create bins number of results using the given scale.
-}
limit : Int -> Analyze.Scale -> Nonempty.Nonempty Float
limit bins scale =
    let
        firstNonEmpty =
            Nonempty.Nonempty (Nonempty.get 0 scale.values) []

        getResultColIndex row =
            getMatrix bins scale |> .lowerClassLimits |> Matrix.getRowCol (row + 1) scale.count |> (\x -> Maybe.withDefault 0 x) |> round

        getResultCol row k bounds =
            let
                id =
                    getResultColIndex row
            in
            ( id - 1, Nonempty.get (id - 1) scale.values :: bounds )

        result =
            List.foldl (\x ( k, bounds ) -> getResultCol x k bounds) ( bins, [] ) (List.range 2 bins) |> Tuple.second
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
        step el ( result, acc ) =
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
                    List.foldl (\col -> updateResultForRow row col i4 variance) jenksResult (List.range 2 cols)
            in
            ( newJenksElement, maybeUpdateResults )

        ( finalJenksElement, finalJenksResult ) =
            List.foldl step ( emptyJenksElement, jenksResult ) (List.drop (count - row) values)
    in
    { lowerClassLimits = Matrix.setRowCol row 1 1 finalJenksResult.lowerClassLimits
    , varianceCombinations = Matrix.setRowCol row 1 finalJenksElement.variance finalJenksResult.varianceCombinations
    }


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
            { lowerClassLimits = Matrix.setRowCol row col (toFloat (i4 + 1)) jenksResult.lowerClassLimits
            , varianceCombinations = Matrix.setRowCol row col val jenksResult.varianceCombinations
            }

        _ ->
            jenksResult
