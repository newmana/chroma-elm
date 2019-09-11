module Chroma.Interpolator exposing (interpolate)

{-| Provides interpolation between two colors of the same color space.


# Definition

@docs interpolate

-}

import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Types as Types
import Color as Color


{-| Return a new color based on interpolating on two colors and a weighting between them. Will return black if the
types are not the same (if one is RGB and CMYK for example).
-}
interpolate : Types.ExtColor -> Types.ExtColor -> Float -> Types.ExtColor
interpolate col1 col2 f =
    case ( col1, col2 ) of
        ( Types.RGBAColor color1, Types.RGBAColor color2 ) ->
            interpolateRGBA color1 color2 f |> Types.RGBAColor

        ( Types.LABColor lab1, Types.LABColor lab2 ) ->
            interpolateLAB lab1 lab2 f |> Types.LABColor

        ( Types.LCHColor lch1, Types.LCHColor lch2 ) ->
            interpolateLCH lch1 lch2 f |> Types.LCHColor

        ( Types.CMYKColor cmyk1, Types.CMYKColor cmyk2 ) ->
            interpolateCMYK cmyk1 cmyk2 f |> Types.CMYKColor

        ( Types.HSLAColor hsla1, Types.HSLAColor hsla2 ) ->
            let
                { luminance, chroma, hue } =
                    interpolateLCH
                        { luminance = hsla1.lightness, chroma = hsla1.saturation, hue = hsla1.hue * 360 }
                        { luminance = hsla2.lightness, chroma = hsla2.saturation, hue = hsla2.hue * 360 }
                        f

                newAlpha =
                    hsla1.alpha + f * (hsla2.alpha - hsla1.alpha)
            in
            { lightness = luminance, saturation = chroma, hue = hue / 360, alpha = newAlpha } |> Types.HSLAColor

        ( Types.HSLADegreesColor hsla1, Types.HSLADegreesColor hsla2 ) ->
            let
                { luminance, chroma, hue } =
                    interpolateLCH
                        { luminance = hsla1.lightness, chroma = hsla1.saturation, hue = hsla1.hueDegrees }
                        { luminance = hsla2.lightness, chroma = hsla2.saturation, hue = hsla2.hueDegrees }
                        f

                newAlpha =
                    hsla1.alpha + f * (hsla2.alpha - hsla1.alpha)
            in
            { lightness = luminance, saturation = chroma, hueDegrees = hue, alpha = newAlpha } |> Types.HSLADegreesColor

        _ ->
            Types.RGBAColor W3CX11.black


interpolateRGBA : Color.Color -> Color.Color -> Float -> Color.Color
interpolateRGBA color1 color2 f =
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

        a =
            rgba1.alpha + f * (rgba2.alpha - rgba1.alpha)
    in
    Color.rgba r g b a


interpolateCMYK : { cyan : Float, magenta : Float, yellow : Float, black : Float } -> { cyan : Float, magenta : Float, yellow : Float, black : Float } -> Float -> { cyan : Float, magenta : Float, yellow : Float, black : Float }
interpolateCMYK cmyk1 cmyk2 f =
    let
        c =
            cmyk1.cyan + f * (cmyk2.cyan - cmyk1.cyan)

        m =
            cmyk1.magenta + f * (cmyk2.magenta - cmyk1.magenta)

        y =
            cmyk1.yellow + f * (cmyk2.yellow - cmyk1.yellow)

        k =
            cmyk1.black + f * (cmyk2.black - cmyk1.black)
    in
    { cyan = c, magenta = m, yellow = y, black = k }


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
