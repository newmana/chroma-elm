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
    , varianceCombinations : Array.Array (Array.Array (Maybe Float))
    }


emptyJenksElement : JenksElement
emptyJenksElement =
    { index = 0
    , sum = 0.0
    , sumOfSquares = 0.0
    , variance = 0.0
    }


defaultResult : Int -> Int -> JenksResult
defaultResult bins nValues =
    { lowerClassLimits = Matrix.makeMatrix bins nValues (\_ -> always 0.0)
    , varianceCombinations = Matrix.makeMatrix bins nValues (\_ -> always (Just 0.0))
    }


{-| Create bins number of results using the given scale.
-}
limit : Int -> Analyze.Scale -> Nonempty.Nonempty Float
limit bins scale =
    Debug.todo "boom"


getData : Int -> Nonempty.Nonempty Float -> List Float
getData index values =
    let
        newResult el oldResult =
            { index = oldResult.index + 1
            , sum = oldResult.sum + el
            , sumOfSquares = oldResult.sumOfSquares + (el * el)
            , variance = (oldResult.sumOfSquares + (el * el)) - (oldResult.sum + el * oldResult.sum + el) / toFloat oldResult.index
            }

        step el ( result, acc ) =
            ( newResult el result
            , if result.index < index then
                el :: acc

              else
                acc
            )
    in
    Tuple.second (Nonempty.foldl step ( emptyJenksElement, [] ) values)
