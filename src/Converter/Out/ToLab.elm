module Converter.Out.ToLab
    exposing
        ( toLab
        )

import Types as Types
import Color as Color
import Converter.In.Cmyk2Rgb as Cmyk2Rgb


--import Converter.In.Lab2Rgb as Lab2Rgb


toLab : Types.ExtColor -> { lightness : Float, a : Float, b : Float }
toLab color =
    case color of
        Types.ExtColor c ->
            Color.toRgb c |> calcLab

        Types.CMYKColor c m y k ->
            Cmyk2Rgb.cmyk2rgb { cyan = c, magenta = m, yellow = y, black = k } |> Color.toRgb |> calcLab

        Types.LABColor l a b ->
            { lightness = l, a = a, b = b }


calcLab : { red : Int, green : Int, blue : Int, alpha : Float } -> { lightness : Float, a : Float, b : Float }
calcLab rgba =
    { lightness = 1, a = 1, b = 1 }
