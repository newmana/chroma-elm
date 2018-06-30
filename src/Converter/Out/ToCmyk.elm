module Converter.Out.ToCmyk
    exposing
        ( toCmyk
        )

import Types as Types
import Color as Color


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
                convert (Color.toRgb c)

            Types.CMYKColor c m y k ->
                { cyan = c, magenta = m, yellow = y, black = k }
