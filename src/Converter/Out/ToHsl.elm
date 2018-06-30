module Converter.Out.ToHsl
    exposing
        ( toHsl
        )

import Types as Types
import Color as Color
import Converter.In.Cmyk2Rgb as Cmyk2Rgb
import Converter.In.Lab2Rgb as Lab2Rgb


toHsl : Types.ExtColor -> { hue : Float, saturation : Float, lightness : Float, alpha : Float }
toHsl color =
    case color of
        Types.ExtColor c ->
            Color.toHsl c

        Types.CMYKColor c m y k ->
            Cmyk2Rgb.cmyk2rgb { cyan = c, magenta = m, yellow = y, black = k } |> Color.toHsl

        Types.LABColor l a b ->
            Lab2Rgb.lab2rgb { lightness = l, a = a, b = b } |> Color.toHsl
