module Chroma.Converter.Out.ToHsl exposing (toHsl)

{-| Convert ExtColor to HSL


# Definition

@docs toHsl

-}

import Chroma.Converter.In.Cmyk2Rgb as Cmyk2Rgb
import Chroma.Converter.In.Lab2Rgb as Lab2Rgb
import Chroma.Types as Types
import Color as Color


{-| TBD
-}
toHsl : Types.ExtColor -> Types.Hsla
toHsl color =
    case color of
        Types.ExtColor c ->
            Color.toHsla c

        Types.CMYKColor cmyk ->
            Cmyk2Rgb.cmyk2rgb cmyk |> Color.toHsla

        Types.LABColor lab ->
            Lab2Rgb.lab2rgb lab |> Color.toHsla
