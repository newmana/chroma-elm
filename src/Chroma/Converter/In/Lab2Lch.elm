module Chroma.Converter.In.Lab2Lch exposing (lab2lch)

{-| Convert LAB to LCH


# Definition

@docs lab2lch

-}

import Chroma.Types as Types


{-| TBD
-}
lab2lch : Types.LabColor -> Types.LchColor
lab2lch { lightness, labA, labB } =
    let
        c =
            labA ^ 2 + labB ^ 2 |> sqrt

        floatMod mod x =
            x - mod * toFloat (floor (x / mod))

        h =
            (atan2 labB labA * 180 / pi) + 360 |> floatMod 360
    in
    { luminance = lightness, chroma = c, hue = h }
