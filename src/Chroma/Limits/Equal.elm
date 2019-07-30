module Chroma.Limits.Equal exposing (limit)

import Chroma.Limits.Analyze as Analyze
import List.Nonempty as Nonempty


limit : Int -> Analyze.Scale -> Nonempty.Nonempty Float
limit bins scale =
    let
        calcBin el =
            scale.min + ((toFloat el / toFloat bins) * (scale.max - scale.min))
    in
    Analyze.genericLimit bins scale calcBin
