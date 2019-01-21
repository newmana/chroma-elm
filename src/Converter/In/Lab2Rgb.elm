module Converter.In.Lab2Rgb
    exposing
        ( lab2rgb
        )

import Color as Color
import Flip as Flip
import Converter.Misc.LabConstants as Constants


lab2rgb : { lightness : Float, labA : Float, labB : Float } -> Color.Color
lab2rgb { lightness, labA, labB } =
    let
        startY =
            (lightness + 16) / 116

        y =
            startY |> lab2xyz |> (*) Constants.yn

        x =
            startY + (labA / 500) |> lab2xyz |> (*) Constants.xn

        z =
            startY - (labB / 200) |> lab2xyz |> (*) Constants.zn

        r =
            (3.2404542 * x) + (-1.5371385 * y) + (-0.4985314 * z) |> xyz2rgb |> range255

        g =
            (-0.969266 * x) + (1.8760108 * y) + (0.041556 * z) |> xyz2rgb |> range255

        b =
            (0.0556434 * x) + (-0.2040259 * y) + (1.0572252 * z) |> xyz2rgb |> range255

        range255 =
            Flip.flip (/) 255
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
        (255 * x)
