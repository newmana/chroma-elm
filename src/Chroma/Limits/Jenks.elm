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
    if rowIndex == 1 && colIndex > 1 && colIndex < bins + 1 then
        1.0

    else
        0.0


initVarianceCombinations : Int -> Int -> Int -> Int -> Float
initVarianceCombinations bins nValues rowIndex colIndex =
    if rowIndex == 2 && colIndex < nValues + 1 then
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

        someResult =
            getData 1 scale.values scale.count (defaultResult bins scale.count) |> .lowerClassLimits |> Array.get 1 |> Maybe.map (\x -> Array.toList x) |> Maybe.withDefault []
    in
    case someResult of
        [] ->
            firstNonEmpty

        head :: tail ->
            Nonempty.Nonempty head tail


getData : Int -> Nonempty.Nonempty Float -> Int -> JenksResult -> JenksResult
getData index values cols jenksResult =
    let
        updateResult row col i4 variance =
            let
                maybeOne =
                    Matrix.getRowCol row col jenksResult.varianceCombinations

                maybeTwo =
                    Matrix.getRowCol i4 (col - 1) jenksResult.varianceCombinations

                fstGreaterThanOrEqualToSnd =
                    Maybe.map2
                        (\fst snd ->
                            if fst >= (variance + snd) then
                                Just (variance + snd)

                            else
                                Nothing
                        )
                        maybeOne
                        maybeTwo

                setJenksResults maybeMaybeVal =
                    case maybeMaybeVal of
                        Just (Just val) ->
                            Just
                                { lowerClassLimits = Matrix.setRowCol row col (toFloat (i4 + 1)) jenksResult.lowerClassLimits
                                , varianceCombinations = Matrix.setRowCol row col val jenksResult.varianceCombinations
                                }

                        _ ->
                            Nothing
            in
            setJenksResults fstGreaterThanOrEqualToSnd

        updateResults row =
            List.foldr identity (List.range 2 cols)

        newElement el oldResult =
            let
                newSum =
                    oldResult.sum + el

                newSumOfSquares =
                    oldResult.sumOfSquares + (el * el)
            in
            { index = oldResult.index + 1
            , sum = newSum
            , sumOfSquares = newSumOfSquares
            , variance = newSumOfSquares - (newSum * newSum) / toFloat oldResult.index
            }

        step el ( result, acc ) =
            ( newElement el result
            , if result.index < index then
                el :: acc

              else
                acc
            )

        calcRow =
            Tuple.second (Nonempty.foldl step ( emptyJenksElement, [] ) values)
    in
    { lowerClassLimits = Matrix.setRowCol index 1 1 jenksResult.lowerClassLimits
    , varianceCombinations = jenksResult.varianceCombinations
    }
