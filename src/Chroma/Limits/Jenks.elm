module Chroma.Limits.Jenks exposing
    ( binned, limit
    , initVarianceCombinations, initLowerClassLimits, getMatrix
    , JenksResult
    )

{-| [Jenks natural breaks optimization](https://en.wikipedia.org/wiki/Jenks_natural_breaks_optimization) is a
clustering algorithm scheme for data to reduce the variance within classes and maximize the variance between classes.


# Definition

@docs binned, limit


# Helpers

@docs initVarianceCombinations, initLowerClassLimits, getMatrix

-}

import Array
import Chroma.Limits.Analyze as Analyze
import Chroma.Limits.Matrix as Matrix
import List.Nonempty as Nonempty
import Set


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


{-| TBD
-}
initLowerClassLimits : Int -> Int -> Int -> Int
initLowerClassLimits _ rowIndex colIndex =
    if rowIndex == 1 && colIndex > 0 then
        1

    else
        0


{-| TBD
-}
initVarianceCombinations : Int -> Int -> Int -> Int -> Float
initVarianceCombinations _ _ rowIndex colIndex =
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
        addOrContinue acc v =
            v :: acc

        slicedResult left _ =
            Nonempty.get left scale.values

        ( result, _ ) =
            genericResult [] slicedResult addOrContinue bins scale
    in
    case result of
        [] ->
            let
                firstNonEmpty =
                    Nonempty.Nonempty (Nonempty.get 0 scale.values) []
            in
            firstNonEmpty

        head :: tail ->
            Nonempty.Nonempty head tail


{-| Return the values in Scale into the given number of bins.

    Analyze.analyze (Nonempty.Nonempty 3 [1,3,4,3])
    |> binned 3
    -->  Nonempty.Nonempty [1] [[3,3,3], [4]]

-}
binned : Int -> Analyze.Scale -> Nonempty.Nonempty (Array.Array Float)
binned bins scale =
    let
        addOrContinue acc v =
            v :: acc

        slicedResult left right =
            Array.map (\i -> Nonempty.get i scale.values) (List.range left (right - 1) |> Array.fromList)

        ( result, _ ) =
            genericResult [] slicedResult addOrContinue bins scale
    in
    case result of
        [] ->
            scale.values |> Nonempty.toList |> Array.fromList |> (\x -> Nonempty.Nonempty x [])

        head :: tail ->
            Nonempty.Nonempty head tail


genericResult : List a -> (Int -> Int -> a) -> (List a -> a -> List a) -> Int -> Analyze.Scale -> ( List a, Int )
genericResult init slicedResult addOrContinue bins scale =
    let
        ( newBins, result ) =
            getMatrix bins scale

        sliceSorted acc bin k lowerClassLimits =
            let
                left =
                    Matrix.getRowCol k (newBins - bin) lowerClassLimits |> Maybe.map (\x -> x - 1) |> Maybe.withDefault 0
            in
            ( addOrContinue acc (slicedResult left k), left )

        all =
            List.foldl (\cluster ( acc, right ) -> sliceSorted acc cluster right result.lowerClassLimits) ( init, scale.count ) (getMatrixIndexes newBins)
    in
    all


getMatrixIndexes : Int -> List Int
getMatrixIndexes bins =
    List.range 0 (bins - 1)


flipAndCount : Set.Set comparable -> List comparable -> ( Int, List comparable ) -> ( Int, List comparable )
flipAndCount existing remaining ( uniqueCount, newList ) =
    case remaining of
        [] ->
            ( uniqueCount, newList )

        first :: rest ->
            if Set.member first existing then
                flipAndCount existing rest ( uniqueCount, first :: newList )

            else
                flipAndCount (Set.insert first existing) rest ( uniqueCount + 1, first :: newList )


{-| TBD
-}
getMatrix : Int -> Analyze.Scale -> ( Int, JenksResult )
getMatrix bins scale =
    let
        ( maxBins, reversedValues ) =
            flipAndCount Set.empty (Nonempty.toList scale.values) ( 0, [] )

        newBins =
            min bins maxBins

        someResult index acc =
            getData reversedValues scale.count (newBins + 1) index acc

        newJenksResult =
            List.foldl someResult (defaultResult (scale.count + 1) (newBins + 1)) (List.range 2 scale.count)
    in
    ( newBins, newJenksResult )


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
