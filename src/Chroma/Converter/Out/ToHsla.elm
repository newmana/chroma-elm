module Chroma.Converter.Out.ToHsla exposing (toHsla, toHslaDegrees, toHslaExt, toHslaDegreesExt)

{-| Convert ExtColor to HSLA


# Definition

@docs toHsla, toHslaDegrees, toHslaExt, toHslaDegreesExt

-}

import Chroma.Converter.In.Cmyk2Rgb as Cmyk2Rgb
import Chroma.Converter.In.Lab2Rgb as Lab2Rgb
import Chroma.Converter.In.Lch2Lab as Lch2Lab
import Chroma.Types as Types
import Color


{-| TBD
-}
toHsla : Types.ExtColor -> Types.HslaColor
toHsla color =
    case color of
        Types.RGBAColor c ->
            Color.toHsla c

        Types.CMYKColor cmyk ->
            Cmyk2Rgb.cmyk2rgb cmyk |> Color.toHsla

        Types.LABColor lab ->
            Lab2Rgb.lab2rgb lab |> Color.toHsla

        Types.LCHColor lch ->
            Lch2Lab.lch2lab lch |> Lab2Rgb.lab2rgb |> Color.toHsla

        Types.HSLAColor hsla ->
            hsla

        Types.HSLADegreesColor { hueDegrees, saturation, lightness, alpha } ->
            { hue = hueDegrees / 360, saturation = saturation, lightness = lightness, alpha = alpha }


{-| TBD
-}
toHslaDegrees : Types.ExtColor -> Types.HslaDegreesColor
toHslaDegrees color =
    let
        toDegrees { hue, saturation, lightness, alpha } =
            { hueDegrees = hue * 360, saturation = saturation, lightness = lightness, alpha = alpha }
    in
    case color of
        Types.RGBAColor c ->
            Color.toHsla c |> toDegrees

        Types.CMYKColor cmyk ->
            Cmyk2Rgb.cmyk2rgb cmyk |> Color.toHsla |> toDegrees

        Types.LABColor lab ->
            Lab2Rgb.lab2rgb lab |> Color.toHsla |> toDegrees

        Types.LCHColor lch ->
            Lch2Lab.lch2lab lch |> Lab2Rgb.lab2rgb |> Color.toHsla |> toDegrees

        Types.HSLAColor { hue, saturation, lightness, alpha } ->
            { hueDegrees = hue * 360, saturation = saturation, lightness = lightness, alpha = alpha }

        Types.HSLADegreesColor hslaDegrees ->
            hslaDegrees


{-| TBD
-}
toHslaExt : Types.ExtColor -> Types.ExtColor
toHslaExt color =
    toHsla color |> Types.HSLAColor


{-| TBD
-}
toHslaDegreesExt : Types.ExtColor -> Types.ExtColor
toHslaDegreesExt color =
    toHslaDegrees color |> Types.HSLADegreesColor
