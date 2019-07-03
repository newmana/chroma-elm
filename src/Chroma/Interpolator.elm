module Chroma.Interpolator exposing (interpolate)

{-| Provides interpolation between two colors of the same color space.


# Definition

@docs interpolate

-}

import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.In.Cmyk2Rgb as Cmyk2Rgb
import Chroma.Converter.Out.ToCmyk as ToCmyk
import Chroma.Types as Types
import Color as Color


{-| Return a new color based on interpolating on two colors and a weighting between them.

CMYK may not work correctly. Will return black if the types are not the same.

-}
interpolate : Types.ExtColor -> Types.ExtColor -> Float -> Types.ExtColor
interpolate col1 col2 f =
    case ( col1, col2 ) of
        ( Types.RGBColor color1, Types.RGBColor color2 ) ->
            interpolateRGB color1 color2 f |> Types.RGBColor

        ( Types.LABColor lab1, Types.LABColor lab2 ) ->
            interpolateLAB lab1 lab2 f |> Types.LABColor

        ( Types.LCHColor lch1, Types.LCHColor lch2 ) ->
            interpolateLCH lch1 lch2 f |> Types.LCHColor

        ( Types.CMYKColor cmyk1, Types.CMYKColor cmyk2 ) ->
            interpolateRGB (cmyk1 |> Cmyk2Rgb.cmyk2rgb) (cmyk2 |> Cmyk2Rgb.cmyk2rgb) f |> Types.RGBColor |> ToCmyk.toCmyk |> Types.CMYKColor

        _ ->
            Types.RGBColor W3CX11.black


interpolateRGB : Color.Color -> Color.Color -> Float -> Color.Color
interpolateRGB color1 color2 f =
    let
        rgba1 =
            Color.toRgba color1

        rgba2 =
            Color.toRgba color2

        r =
            rgba1.red + f * (rgba2.red - rgba1.red)

        g =
            rgba1.green + f * (rgba2.green - rgba1.green)

        b =
            rgba1.blue + f * (rgba2.blue - rgba1.blue)
    in
    Color.rgb r g b


interpolateLAB : { lightness : Float, labA : Float, labB : Float } -> { lightness : Float, labA : Float, labB : Float } -> Float -> { lightness : Float, labA : Float, labB : Float }
interpolateLAB color1 color2 f =
    { lightness = color1.lightness + f * (color2.lightness - color1.lightness)
    , labA = color1.labA + f * (color2.labA - color1.labA)
    , labB = color1.labB + f * (color2.labB - color1.labB)
    }


interpolateLCH : { luminance : Float, chroma : Float, hue : Float } -> { luminance : Float, chroma : Float, hue : Float } -> Float -> { luminance : Float, chroma : Float, hue : Float }
interpolateLCH color1 color2 f =
    let
        dh =
            if color2.hue > color1.hue && (color2.hue - color1.hue > 180) then
                color2.hue - (color1.hue + 360)

            else if color2.hue < color1.hue && (color1.hue - color2.hue > 180) then
                color2.hue + 360 - color1.hue

            else
                color2.hue - color1.hue
    in
    { luminance = color1.luminance + f * (color2.luminance - color1.luminance)
    , chroma = color1.chroma + f * (color2.chroma - color1.chroma)
    , hue = color1.hue + f * dh
    }
