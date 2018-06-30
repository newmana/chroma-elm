module Converter.Out.ToCmyk
    exposing
        ( toCmyk
        )

import Types as Types
import Color as Color
import Converter.In.Lab2Rgb as Lab2Rgb


toCmyk : Types.ExtColor -> { cyan : Float, magenta : Float, yellow : Float, black : Float }
toCmyk color =
    let
        convert { alpha, blue, green, red } =
            let
                ratio =
                    toFloat >> flip (/) 255

                r =
                    ratio red

                g =
                    ratio green

                b =
                    ratio blue

                f x =
                    if k < 1 then
                        (1 - x - k) / (1 - k)
                    else
                        0

                k =
                    (max g b) |> max r |> (-) 1
            in
                { cyan = f r, magenta = f g, yellow = f b, black = k }
    in
        case color of
            Types.ExtColor c ->
                Color.toRgb c |> convert

            Types.CMYKColor c m y k ->
                { cyan = c, magenta = m, yellow = y, black = k }

            Types.LABColor l a b ->
                Lab2Rgb.lab2rgb { lightness = l, a = a, b = b } |> Color.toRgb |> convert
