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

        rest =
            if bins == 1 then
                []

            else
                List.map calcBin (1 :: List.range 2 (bins - 1))
    in
    Nonempty.Nonempty scale.min (rest ++ [ scale.max ])
