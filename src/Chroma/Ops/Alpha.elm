module Chroma.Ops.Alpha exposing
    ( alpha
    , setAlpha
    )

{-| Get or change Alpha value


# Definition

@docs alpha

-}

import Chroma.Converter.In.Lab2Lch as Lab2Lch
import Chroma.Converter.Misc.LabConstants as LabConstants
import Chroma.Converter.Out.ToCmyk as OutCymk
import Chroma.Converter.Out.ToLab as OutLab
import Chroma.Converter.Out.ToRgb as OutRgb
import Chroma.Types as Types
import Color as Color


{-| Return a new color based on the new alpha value using LAB color space.
-}
setAlpha : Float -> Types.ExtColor -> Types.ExtColor
setAlpha amount color =
    let
        rgbA =
            OutRgb.toRgba color

        newLab =
            { rgbA | alpha = amount } |> Color.fromRgba |> Types.RGBColor |> OutLab.toLab
    in
    case color of
        Types.RGBColor _ ->
            { rgbA | alpha = amount } |> Color.fromRgba |> Types.RGBColor

        Types.LABColor _ ->
            newLab |> Types.LABColor

        Types.LCHColor _ ->
            newLab |> Lab2Lch.lab2lch |> Types.LCHColor

        Types.CMYKColor _ ->
            { rgbA | alpha = amount } |> Color.fromRgba |> Types.RGBColor |> OutCymk.toCmyk |> Types.CMYKColor


{-| Return the alpha value
-}
alpha : Types.ExtColor -> Float
alpha color =
    OutRgb.toRgba color |> .alpha
