module Chroma.Converter.Out.ToRgb exposing (toRgba, toRgba255, toNonEmptyList)

{-| Convert ExtColors to RGB record types or array


# Definition

@docs toRgba, toRgba255, toNonEmptyList

-}

import Chroma.Converter.In.Cmyk2Rgb as Cmyk2Rgb
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
    in
    { red = realColor.red * 255 |> round, green = realColor.green * 255 |> round, blue = realColor.blue * 255 |> round, alpha = realColor.alpha }


{-| Takes a result from getColor and returns Float (0-1) RGB values.
-}
toRgba : Types.ExtColor -> Types.RgbaColor
toRgba color =
    case color of
        Types.RGBColor c ->
            Color.toRgba c

        Types.CMYKColor cmyk ->
            Cmyk2Rgb.cmyk2rgb cmyk |> Color.toRgba

        Types.LABColor lab ->
            Lab2Rgb.lab2rgb lab |> Color.toRgba

        Types.LCHColor lch ->
            Lch2Lab.lch2lab lch |> Lab2Rgb.lab2rgb |> Color.toRgba


{-| TBD
-}
toNonEmptyList : Types.ExtColor -> Nonempty.Nonempty Float
toNonEmptyList color =
    case color of
        Types.RGBColor c ->
            let
                { red, green, blue, alpha } =
                    Color.toRgba c
            in
            Nonempty.Nonempty red [ green, blue, alpha ]

        Types.CMYKColor { cyan, magenta, yellow, black } ->
            Nonempty.Nonempty cyan [ magenta, yellow, black ]

        Types.LABColor { lightness, labA, labB } ->
            Nonempty.Nonempty lightness [ labA, labB ]

        Types.LCHColor { luminance, chroma, hue } ->
            Nonempty.Nonempty luminance [ chroma, hue ]
