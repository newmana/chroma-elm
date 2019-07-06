module Chroma.Converter.In.Hsla2Rgb exposing (hsla2rgb, hslaDegrees2rgb)

{-| Convert HSL to RGB


# Definition

@docs hsla2rgb, hslaDegrees2rgb

-}

import Chroma.Types as Types
import Color as Color


{-| Hue, Saturation and Lightness are clamped 0..1.
-}
hsla2rgb : Types.HslaColor -> Color.Color
hsla2rgb { hue, saturation, lightness, alpha } =
    Color.hsla hue saturation lightness alpha


{-| Hue is measured in degrees and wrapped to the range 0..360. Saturation and Lightness are clamped 0..1.
-}
hslaDegrees2rgb : Types.HslaDegreesColor -> Color.Color
hslaDegrees2rgb { hueDegrees, saturation, lightness, alpha } =
    Color.hsla (hueDegrees / 360) saturation lightness alpha
