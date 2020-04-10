module Chroma.Converter.Misc.ColorSpace exposing (colorConvert, toNonEmptyList, combine, rollingAverage)

{-| For dealing with color space calculations.


# Definition

@docs colorConvert, toNonEmptyList, combine, rollingAverage

-}

import Chroma.Converter.Out.ToCmyk as ToCmyk
import Chroma.Converter.Out.ToHsla as ToHsla
import Chroma.Converter.Out.ToLab as ToLab
import Chroma.Converter.Out.ToLch as ToLch
import Chroma.Converter.Out.ToRgba as ToRgba
import Chroma.Interpolator as Interpolator
import Chroma.Types as Types
import Color as Color
import List.Nonempty as Nonempty


colorConvert : Types.Mode -> Types.ExtColor -> Types.ExtColor
colorConvert mode initColor =
    let
        convert =
            case mode of
                Types.RGBA ->
                    ToRgba.toRgbaExt

                Types.CMYK ->
                    ToCmyk.toCmykExt

                Types.LAB ->
                    ToLab.toLabExt

                Types.LCH ->
                    ToLch.toLchExt

                Types.HSLA ->
                    ToHsla.toHslaExt

                Types.HSLADegrees ->
                    ToHsla.toHslaDegreesExt
    in
    convert initColor


rollingAverage : Nonempty.Nonempty Types.ExtColor -> Types.ExtColor
rollingAverage extCols =
    let
        start =
            ( 2, Nonempty.head extCols )

        rest =
            Nonempty.tail extCols

        ( _, result ) =
            List.foldl (\newCol ( index, currentCol ) -> ( index + 1, Interpolator.interpolate currentCol newCol (1 / index) )) start rest
    in
    result


toNonEmptyList : Types.ExtColor -> Nonempty.Nonempty Float
toNonEmptyList color =
    case color of
        Types.RGBAColor c ->
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

        Types.HSLAColor { hue, saturation, lightness, alpha } ->
            Nonempty.Nonempty hue [ saturation, lightness, alpha ]

        Types.HSLADegreesColor { hueDegrees, saturation, lightness, alpha } ->
            Nonempty.Nonempty hueDegrees [ saturation, lightness, alpha ]


combine : Nonempty.Nonempty (Result a b) -> Result a (Nonempty.Nonempty b)
combine list =
    let
        startOrErr =
            Nonempty.head list |> Result.andThen (Nonempty.fromElement >> Ok)
    in
    Nonempty.foldl (Result.map2 Nonempty.cons) startOrErr (Nonempty.pop list)
