module Converter.In.Cmyk2Rgb exposing (cmyk2rgb)

import Color as Color
import Types as Types


cmyk2rgb : { cyan : Float, magenta : Float, yellow : Float, black : Float } -> Color.Color
cmyk2rgb { cyan, magenta, yellow, black } =
    let
        convert x =
            if x >= 1 then
                0

            else
                (1 - x) * (1 - black)
    in
    if black >= 1 then
        Color.rgb 0.0 0.0 0.0

    else
        Color.rgb (convert cyan) (convert magenta) (convert yellow)
