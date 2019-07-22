module Chroma.Converter.In.Lch2Lab exposing (lch2lab)

{-| Convert LCH to LAB


# Definition

@docs lch2lab

-}

import Chroma.Types as Types


{-| TBD
-}
lch2lab : Types.LchColor -> Types.LabColor
lch2lab { luminance, chroma, hue } =
    let
        hueInDegrees =
            if isNaN hue then
                0

            else
                degrees hue
    in
    { lightness = luminance, labA = cos hueInDegrees * chroma, labB = sin hueInDegrees * chroma }
