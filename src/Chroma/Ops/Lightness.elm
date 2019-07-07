module Chroma.Ops.Lightness exposing (darken, brighten)

{-| Change the lightness of a color value.


# Definition

@docs darken, brighten

-}

import Chroma.Converter.In.Lab2Lch as Lab2Lch
import Chroma.Converter.In.Lab2Rgb as Lab2Rgb
import Chroma.Converter.Misc.LabConstants as LabConstants
import Chroma.Converter.Out.ToCmyk as ToCymk
import Chroma.Converter.Out.ToHsla as ToHsla
import Chroma.Converter.Out.ToLab as ToLab
import Chroma.Types as Types


{-| Darken
-}
darken : Float -> Types.ExtColor -> Types.ExtColor
darken amount color =
    let
        { lightness, labA, labB } =
            ToLab.toLab color

        newL =
            lightness - LabConstants.kn * amount

        newLab =
            { lightness = newL, labA = labA, labB = labB } |> Types.LABColor
    in
    case color of
        Types.RGBAColor _ ->
            Lab2Rgb.lab2rgb { lightness = newL, labA = labA, labB = labB } |> Types.RGBAColor

        Types.LABColor _ ->
            newLab

        Types.LCHColor _ ->
            Lab2Lch.lab2lch { lightness = newL, labA = labA, labB = labB } |> Types.LCHColor

        Types.CMYKColor _ ->
            newLab |> ToCymk.toCmyk |> Types.CMYKColor

        Types.HSLAColor _ ->
            newLab |> ToHsla.toHsla |> Types.HSLAColor

        Types.HSLADegreesColor _ ->
            newLab |> ToHsla.toHslaDegrees |> Types.HSLADegreesColor


{-| Brighten
-}
brighten : Float -> Types.ExtColor -> Types.ExtColor
brighten amount color =
    darken (amount * -1) color
