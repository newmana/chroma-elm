module Chroma.Ops.Saturate exposing (saturate, desaturate)

{-| Increase or decrease color saturation.


# Definition

@docs saturate, desaturate

-}

import Chroma.Converter.In.Lab2Rgb as Lab2Rgb
import Chroma.Converter.In.Lch2Lab as Lch2Lab
import Chroma.Converter.Misc.LabConstants as LabConstants
import Chroma.Converter.Out.ToCmyk as ToCymk
import Chroma.Converter.Out.ToHsla as ToHsla
import Chroma.Converter.Out.ToLab as ToLab
import Chroma.Converter.Out.ToLch as ToLch
import Chroma.Types as Types


{-| Saturate
-}
saturate : Float -> Types.ExtColor -> Types.ExtColor
saturate amount color =
    let
        { luminance, chroma, hue } =
            ToLch.toLch color

        calcNewC =
            chroma + LabConstants.kn * amount

        newC =
            clamp 0 230 calcNewC

        newLch =
            { luminance = luminance, chroma = newC, hue = hue }

        newLab =
            Lch2Lab.lch2lab newLch

        newLabColor =
            newLab |> Types.LABColor
    in
    case color of
        Types.RGBAColor _ ->
            newLab |> Lab2Rgb.lab2rgb |> Types.RGBAColor

        Types.LABColor _ ->
            newLabColor

        Types.LCHColor _ ->
            newLch |> Types.LCHColor

        Types.CMYKColor _ ->
            newLabColor |> ToCymk.toCmyk |> Types.CMYKColor

        Types.HSLAColor _ ->
            newLab |> Types.LABColor |> ToHsla.toHsla |> Types.HSLAColor

        Types.HSLADegreesColor _ ->
            newLab |> Types.LABColor |> ToHsla.toHslaDegrees |> Types.HSLADegreesColor


{-| Desaturate
-}
desaturate : Float -> Types.ExtColor -> Types.ExtColor
desaturate amount color =
    saturate (amount * -1) color
