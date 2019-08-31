module Chroma.Converter.Out.ToRgba exposing (toRgba, toRgba255, toRgbaExt)

{-| Convert ExtColors to RGB record types or array


# Definition

@docs toRgba, toRgba255, toRgbaExt

-}

import Chroma.Converter.In.Cmyk2Rgb as Cmyk2Rgb
import Chroma.Converter.In.Hsla2Rgb as Hsla2Rgb
import Chroma.Converter.In.Lab2Rgb as Lab2Rgb
import Chroma.Converter.In.Lch2Lab as Lch2Lab
import Chroma.Types as Types
import Color as Color
import List.Nonempty as Nonempty


{-| Takes a result from getColor and returns Integer (0-255) RGB values.
-}
toRgba255 : Types.ExtColor -> Types.Rgba255Color
toRgba255 color =
    let
        realColor =
            toRgba color

        convert =
            clamp 0 1 >> (\x -> x * 255) >> round
    in
    { red = convert realColor.red, green = convert realColor.green, blue = convert realColor.blue, alpha = realColor.alpha }


{-| Takes a result from getColor and returns Float (0-1) RGB values.
-}
toRgba : Types.ExtColor -> Types.RgbaColor
toRgba color =
    case color of
        Types.RGBAColor c ->
            Color.toRgba c

        Types.CMYKColor cmyk ->
            Cmyk2Rgb.cmyk2rgb cmyk |> Color.toRgba

        Types.LABColor lab ->
            Lab2Rgb.lab2rgb lab |> Color.toRgba

        Types.LCHColor lch ->
            Lch2Lab.lch2lab lch |> Lab2Rgb.lab2rgb |> Color.toRgba

        Types.HSLAColor hsla ->
            Hsla2Rgb.hsla2rgb hsla |> Color.toRgba

        Types.HSLADegreesColor hslaDegrees ->
            Hsla2Rgb.hslaDegrees2rgb hslaDegrees |> Color.toRgba


{-| TBD
-}
toRgbaExt : Types.ExtColor -> Types.ExtColor
toRgbaExt color =
    let
        { red, green, blue, alpha } =
            toRgba color
    in
    Color.rgba red green blue alpha |> Types.RGBAColor
