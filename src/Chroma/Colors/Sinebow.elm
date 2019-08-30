module Chroma.Colors.Sinebow exposing (getColor)

{-| [Sinebow](https://basecase.org/env/on-rainbows) color scale - sine generated rainbow.


# Color Scale

@docs getColor

-}

import Color exposing (Color, rgb255)


{-| TBD
-}
getColor : Float -> Color
getColor t =
    let
        boundedT =
            clamp 0 1 t

        oneThirdPi =
            pi / 3

        twoThirdPi =
            (2 * pi) / 3

        newT =
            (0.5 - boundedT) * pi

        r =
            255 * (sin newT ^ 2) |> round

        g =
            255 * (sin (newT + oneThirdPi) ^ 2) |> round

        b =
            255 * (sin (newT + twoThirdPi) ^ 2) |> round
    in
    rgb255 r g b
