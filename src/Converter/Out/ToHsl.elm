module Converter.Out.ToHsl exposing (toHsl)

import Color as Color
import Converter.In.Cmyk2Rgb as Cmyk2Rgb
import Converter.In.Lab2Rgb as Lab2Rgb
import Types as Types


toHsl : Types.ExtColor -> Types.Hsla
toHsl color =
    case color of
        Types.ExtColor c ->
            Color.toHsl c

        Types.CMYKColor cmyk ->
            Cmyk2Rgb.cmyk2rgb cmyk |> Color.toHsl

        Types.LABColor lab ->
            Lab2Rgb.lab2rgb lab |> Color.toHsl
