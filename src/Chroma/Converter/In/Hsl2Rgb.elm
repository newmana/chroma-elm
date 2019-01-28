module Chroma.Converter.In.Hsl2Rgb exposing (hsl2rgb, hslDegrees2rgb)

{-| Convert HSL to RGB


# Definition

@docs hsl2rgb, hslDegrees2rgb

-}

import Chroma.Types as Types
import Color as Color


{-| Hue is measured in degrees and wrapped to the range 0..360. Saturation and Lightness are clamped 0..1.
-}
hslDegrees2rgb : Types.HslaDegrees -> Color.Color
hslDegrees2rgb { hue, saturation, lightness, alpha } =
    Color.hsla (hue / 360) saturation lightness alpha


{-| Hue, Saturation and Lightness are clamped 0..1.
-}
hsl2rgb : Types.Hsla -> Color.Color
hsl2rgb { hue, saturation, lightness, alpha } =
    Color.hsla hue saturation lightness alpha
