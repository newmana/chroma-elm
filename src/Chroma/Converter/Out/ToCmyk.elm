module Chroma.Converter.Out.ToCmyk exposing (toCmyk, toCmykExt)

{-| Convert ExtColor to CMYK


# Definition

@docs toCmyk, toCmykExt

-}

import Chroma.Converter.In.Hsla2Rgb as Hsla2Rgb
import Chroma.Converter.In.Lab2Rgb as Lab2Rgb
import Chroma.Converter.In.Lch2Lab as Lch2Lab
import Chroma.Types as Types
import Color as Color


{-| TBD
-}
toCmyk : Types.ExtColor -> Types.CymkColor
toCmyk color =
    let
        convert { red, green, blue, alpha } =
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

        convertLab lab =
            Lab2Rgb.lab2rgb lab |> Color.toRgba |> convert
    in
    case color of
        Types.RGBAColor c ->
            Color.toRgba c |> convert

        Types.CMYKColor cmyk ->
            cmyk

        Types.LABColor lab ->
            convertLab lab

        Types.LCHColor lch ->
            Lch2Lab.lch2lab lch |> convertLab

        Types.HSLAColor hsla ->
            Hsla2Rgb.hsla2rgb hsla |> Color.toRgba |> convert

        Types.HSLADegreesColor hslaDegrees ->
            Hsla2Rgb.hslaDegrees2rgb hslaDegrees |> Color.toRgba |> convert


{-| TBD
-}
toCmykExt : Types.ExtColor -> Types.ExtColor
toCmykExt color =
    toCmyk color |> Types.CMYKColor
