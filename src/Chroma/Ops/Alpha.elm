module Chroma.Ops.Alpha exposing (setAlpha, alpha)

{-| Get or change Alpha value


# Definition

@docs setAlpha, alpha

-}

import Chroma.Converter.In.Lab2Lch as Lab2Lch
import Chroma.Converter.Misc.LabConstants as LabConstants
import Chroma.Converter.Out.ToCmyk as ToCymk
import Chroma.Converter.Out.ToHsla as ToHsla
import Chroma.Converter.Out.ToLab as ToLab
import Chroma.Converter.Out.ToRgb as ToRgb
import Chroma.Types as Types
import Color as Color


{-| Return a new color based on the new alpha value using LAB color space.
-}
setAlpha : Float -> Types.ExtColor -> Types.ExtColor
setAlpha amount color =
    let
        rgbA =
            ToRgb.toRgba color

        newRgbColor =
            { rgbA | alpha = amount } |> Color.fromRgba |> Types.RGBColor

        newLab =
            newRgbColor |> ToLab.toLab
    in
    case color of
        Types.RGBColor _ ->
            newRgbColor

        Types.LABColor _ ->
            newLab |> Types.LABColor

        Types.LCHColor _ ->
            newLab |> Lab2Lch.lab2lch |> Types.LCHColor

        Types.CMYKColor _ ->
            newRgbColor |> ToCymk.toCmyk |> Types.CMYKColor

        Types.HSLAColor _ ->
            newLab |> Types.LABColor |> ToHsla.toHsla |> Types.HSLAColor

        Types.HSLADegreesColor _ ->
            newLab |> Types.LABColor |> ToHsla.toHslaDegrees |> Types.HSLADegreesColor


{-| Return the alpha value
-}
alpha : Types.ExtColor -> Float
alpha color =
    ToRgb.toRgba color |> .alpha
