module Chroma.Limits.Jenks exposing (..)

{-| [Jenks natural breaks optimization](https://en.wikipedia.org/wiki/Jenks_natural_breaks_optimization) is a
clustering algorithm scheme for data to reduce the variance within classes and maximize the variance between classes.


# Definition

@docs limit

-}

import Array as Array
import Chroma.Limits.Analyze as Analyze
import List.Nonempty as Nonempty


type alias JenksElement =
    { lowerClassLimit : Float
    , variance : Maybe Float
    }


{-| Create bins number of results using the given scale.
-}
limit : Int -> Analyze.Scale -> Nonempty.Nonempty Float
limit bins scale =
    Debug.todo "boom"


getData : Int -> Nonempty.Nonempty Float -> List Float
getData index values =
    let
        step el ( i, acc ) =
            ( i + 1
            , if i < index then
                el :: acc

              else
                acc
            )
    in
    Tuple.second (Nonempty.foldl step ( 0, [] ) values)
