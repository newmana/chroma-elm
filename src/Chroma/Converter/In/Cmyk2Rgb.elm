module Chroma.Converter.In.Cmyk2Rgb exposing (cmyk2rgb)

{-| Convert CMYK to RGB (floats)


# Definition

@docs cmyk2rgb

-}

import Chroma.Types as Types
import Color


{-| TBD
-}
cmyk2rgb : Types.CymkColor -> Color.Color
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
