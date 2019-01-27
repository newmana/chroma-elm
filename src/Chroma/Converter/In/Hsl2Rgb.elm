module Chroma.Converter.In.Hsl2Rgb exposing (hsl2rgb)

{-| Convert HSL to RGB


# Definition

@docs hsl2rgb

-}

import Chroma.Types as Types
import Color as Color


{-| TBD
-}
hsl2rgb : Types.Hsla -> Color.Color
hsl2rgb { hue, saturation, lightness, alpha } =
    Color.hsla hue saturation lightness alpha
