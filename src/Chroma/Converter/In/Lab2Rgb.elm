module Chroma.Converter.In.Lab2Rgb exposing (lab2rgb)

{-| Convert LAB to RGB (floats)


# Definition

@docs lab2rgb

-}

import Chroma.Converter.Misc.LabConstants as Constants
import Chroma.Types as Types
import Color as Color


{-| TBD
-}
lab2rgb : Types.LabColor -> Color.Color
lab2rgb lab =
    let
        startY =
            (lab.lightness + 16) / 116

        y =
            startY |> lab2xyz |> (*) Constants.yn

        x =
            startY + (lab.labA / 500) |> lab2xyz |> (*) Constants.xn

        z =
            startY - (lab.labB / 200) |> lab2xyz |> (*) Constants.zn

        r =
            (3.2404542 * x) + (-1.5371385 * y) + (-0.4985314 * z) |> xyz2rgb

        g =
            (-0.969266 * x) + (1.8760108 * y) + (0.041556 * z) |> xyz2rgb

        b =
            (0.0556434 * x) + (-0.2040259 * y) + (1.0572252 * z) |> xyz2rgb
    in
    Color.rgb r g b


lab2xyz : Float -> Float
lab2xyz t =
    if t > Constants.t1 then
        t ^ 3

    else
        Constants.t2 * (t - Constants.t0)


xyz2rgb : Float -> Float
xyz2rgb r =
    let
        x =
            if r <= 0.00304 then
                12.92 * r

            else
                1.055 * r ^ (1 / 2.4) - 0.055
    in
    x
