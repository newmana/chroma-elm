module Chroma.Converter.Misc.ColorSpace exposing (colorConvert, toNonEmptyList, avgNonEmptyLists, combine, nonEmptyListToExtColor)

{-| For dealing with color space calculations.


# Definition

@docs colorConvert, toNonEmptyList, avgNonEmptyLists, combine, nonEmptyListToExtColor

-}

import Chroma.Converter.Out.ToCmyk as ToCmyk
import Chroma.Converter.Out.ToHsla as ToHsla
import Chroma.Converter.Out.ToLab as ToLab
import Chroma.Converter.Out.ToLch as ToLch
import Chroma.Converter.Out.ToRgba as ToRgba
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


nonEmptyListToExtColor : Types.Mode -> Nonempty.Nonempty Float -> Types.ExtColor
nonEmptyListToExtColor mode floats =
    case mode of
        Types.RGBA ->
            Types.RGBAColor
                (Color.rgba
                    (Nonempty.get 0 floats)
                    (Nonempty.get 1 floats)
                    (Nonempty.get 2 floats)
                    (Nonempty.get 3 floats)
                )

        Types.CMYK ->
            Types.CMYKColor
                { cyan = Nonempty.get 0 floats
                , magenta = Nonempty.get 1 floats
                , yellow = Nonempty.get 2 floats
                , black = Nonempty.get 3 floats
                }

        Types.LAB ->
            Types.LABColor
                { lightness = Nonempty.get 0 floats
                , labA = Nonempty.get 1 floats
                , labB = Nonempty.get 2 floats
                }

        Types.LCH ->
            Types.LCHColor
                { luminance = Nonempty.get 0 floats
                , chroma = Nonempty.get 1 floats
                , hue = Nonempty.get 2 floats
                }

        Types.HSLA ->
            Types.HSLAColor
                { hue = Nonempty.get 0 floats
                , saturation = Nonempty.get 1 floats
                , lightness = Nonempty.get 2 floats
                , alpha = Nonempty.get 3 floats
                }

        Types.HSLADegrees ->
            Types.HSLADegreesColor
                { hueDegrees = Nonempty.get 0 floats
                , saturation = Nonempty.get 1 floats
                , lightness = Nonempty.get 2 floats
                , alpha = Nonempty.get 3 floats
                }


avgNonEmptyLists : Nonempty.Nonempty (Nonempty.Nonempty Float) -> Nonempty.Nonempty Float
avgNonEmptyLists lists =
    let
        rest =
            Nonempty.tail lists

        numElems =
            Nonempty.length lists |> toFloat
    in
    Nonempty.indexedMap (\i el -> sumListsElem i el rest / numElems) (Nonempty.head lists)


sumListsElem : Int -> Float -> List (Nonempty.Nonempty Float) -> Float
sumListsElem index start lists =
    List.foldl (\el acc -> Nonempty.get index el + acc) start lists


combine : Nonempty.Nonempty (Result a b) -> Result a (Nonempty.Nonempty b)
combine list =
    let
        startOrErr =
            Nonempty.head list |> Result.andThen (Nonempty.fromElement >> Ok)
    in
    Nonempty.foldl (Result.map2 Nonempty.cons) startOrErr (Nonempty.pop list)
