module Chroma.Converter.Out.ToLab exposing (toLab, toLabExtColor)

import Chroma.Converter.In.Cmyk2Rgb as Cmyk2Rgb
import Chroma.Converter.Misc.LabConstants as Constants
import Chroma.Types as Types
import Color as Color


toLabExtColor : Color.Color -> Types.ExtColor
toLabExtColor color =
    toLab (Types.ExtColor color) |> Types.LABColor


toLab : Types.ExtColor -> Types.LabColor
toLab color =
    case color of
        Types.ExtColor c ->
            Color.toRgba c |> calcLab

        Types.CMYKColor cmyk ->
            Cmyk2Rgb.cmyk2rgb cmyk |> Color.toRgba |> calcLab

        Types.LABColor lab ->
            lab


calcLab : Types.RgbaColor -> Types.LabColor
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
rgb2xyz c =
    if c > 0.04045 then
        ((c + 0.055) / 1.055) ^ 2.4

    else
        c / 12.92


xyz2lab : Float -> Float
xyz2lab t =
    if t > Constants.t3 then
        t ^ (1 / 3)

    else
        t / Constants.t2 + Constants.t0
