module Chroma.Limits.Equal exposing (limit)

import Chroma.Limits.Analyze as Analyze
import List.Nonempty as Nonempty


limit : Int -> Analyze.Scale -> Nonempty.Nonempty Float
limit bins scale =
    let
        calcBin el =
            scale.min + ((toFloat el / toFloat bins) * (scale.max - scale.min))

        rest =
            if bins == 1 then
                []

            else
                List.map calcBin (1 :: List.range 2 (bins - 1))
    in
    Nonempty.Nonempty scale.min (rest ++ [ scale.max ])
