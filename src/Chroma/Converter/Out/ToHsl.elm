module Chroma.Converter.Out.ToHsl exposing (toHsl)

import Chroma.Converter.In.Cmyk2Rgb as Cmyk2Rgb
import Chroma.Converter.In.Lab2Rgb as Lab2Rgb
import Chroma.Types as Types
import Color as Color


toHsl : Types.ExtColor -> Types.Hsla
toHsl color =
    case color of
        Types.ExtColor c ->
            Color.toHsl c

        Types.CMYKColor cmyk ->
            Cmyk2Rgb.cmyk2rgb cmyk |> Color.toHsl

        Types.LABColor lab ->
            Lab2Rgb.lab2rgb lab |> Color.toHsl
