module Converter.Out.ToCmyk exposing (toCmyk)

import Color as Color
import Converter.In.Lab2Rgb as Lab2Rgb
import Flip as Flip
import Types as Types


toCmyk : Types.ExtColor -> { cyan : Float, magenta : Float, yellow : Float, black : Float }
toCmyk color =
    let
        convert { alpha, blue, green, red } =
            let
                f x =
                    if k < 1 then
                        (1 - x - k) / (1 - k)

                    else
                        0

                k =
                    max green blue |> max red |> (-) 1
            in
            { cyan = f red, magenta = f green, yellow = f blue, black = k }
    in
    case color of
        Types.ExtColor c ->
            Color.toRgba c |> convert

        Types.CMYKColor c m y k ->
            { cyan = c, magenta = m, yellow = y, black = k }

        Types.LABColor l a b ->
            Lab2Rgb.lab2rgb { lightness = l, labA = a, labB = b } |> Color.toRgba |> convert
