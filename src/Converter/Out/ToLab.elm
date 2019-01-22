module Converter.Out.ToLab exposing (toLab, toLabExtColor)

import Color as Color
import Converter.In.Cmyk2Rgb as Cmyk2Rgb
import Converter.Misc.LabConstants as Constants
import Types as Types


toLabExtColor : Color.Color -> Types.ExtColor
toLabExtColor color =
    let
        lab =
            toLab (Types.ExtColor color)
    in
    Types.LABColor lab.lightness lab.labA lab.labB


toLab : Types.ExtColor -> { lightness : Float, labA : Float, labB : Float }
toLab color =
    case color of
        Types.ExtColor c ->
            Color.toRgba c |> calcLab

        Types.CMYKColor c m y k ->
            Cmyk2Rgb.cmyk2rgb { cyan = c, magenta = m, yellow = y, black = k } |> Color.toRgba |> calcLab

        Types.LABColor l a b ->
            { lightness = l, labA = a, labB = b }


calcLab : { red : Float, green : Float, blue : Float, alpha : Float } -> { lightness : Float, labA : Float, labB : Float }
calcLab { red, green, blue, alpha } =
    let
        r =
            rgb2xyz red

        g =
            rgb2xyz green

        b =
            rgb2xyz blue

        x =
            (0.4124564 * r + 0.3575761 * g + 0.1804375 * b) / Constants.xn |> xyz2lab

        y =
            (0.2126729 * r + 0.7151522 * g + 0.072175 * b) / Constants.yn |> xyz2lab

        z =
            (0.0193339 * r + 0.119192 * g + 0.9503041 * b) / Constants.zn |> xyz2lab

        labL =
            116 * y - 16

        labA =
            500 * (x - y)

        labB =
            200 * (y - z)
    in
    { lightness = labL, labA = labA, labB = labB }


rgb2xyz : Float -> Float
rgb2xyz r =
    if r <= 0.04045 then
        r / 12.92

    else
        ((r + 0.055) / 1.055) ^ 2.4


xyz2lab : Float -> Float
xyz2lab t =
    if t > Constants.t3 then
        t ^ (1 / 3)

    else
        t / Constants.t2 + Constants.t0
