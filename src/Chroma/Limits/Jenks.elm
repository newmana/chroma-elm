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
    Debug.todo "boom"


getData : Int -> Nonempty.Nonempty Float -> JenksResult -> JenksResult
getData index values jenksResult =
    let
        newResult el oldResult =
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
            ( newResult el result
            , if result.index < index then
                el :: acc

              else
                acc
            )

        calcRow =
            Tuple.second (Nonempty.foldl step ( emptyJenksElement, [] ) values)
    in
    { lowerClassLimits = Matrix.setMatrixRowCol index 1 1 jenksResult.lowerClassLimits
    , varianceCombinations = jenksResult.varianceCombinations
    }
