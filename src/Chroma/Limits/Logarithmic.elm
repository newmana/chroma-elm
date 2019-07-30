module Chroma.Limits.Logarithmic exposing (limit)

import Chroma.Limits.Analyze as Analyze
import List.Nonempty as Nonempty


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
