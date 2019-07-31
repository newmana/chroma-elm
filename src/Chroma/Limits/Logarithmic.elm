module Chroma.Limits.Logarithmic exposing (limit)

{-| Create logarithimically spaced values.


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
        minLog =
            logBase 10 e * logBase e scale.min

        maxLog =
            logBase 10 e * logBase e scale.max

        calcBin el =
            10 ^ (minLog + ((toFloat el / toFloat bins) * (maxLog - minLog)))
    in
    Analyze.genericLimit bins scale calcBin
