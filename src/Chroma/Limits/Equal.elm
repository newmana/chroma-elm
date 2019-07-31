module Chroma.Limits.Equal exposing (limit)

{-| Create equally spaced values.


# Definition

@docs limit

-}

import Chroma.Limits.Analyze as Analyze
import List.Nonempty as Nonempty


{-| Create bins number of results using the given scale.
-}
limit : Int -> Analyze.Scale -> Nonempty.Nonempty Float
limit bins scale =
    let
        calcBin el =
            scale.min + ((toFloat el / toFloat bins) * (scale.max - scale.min))
    in
    Analyze.genericLimit bins scale calcBin
