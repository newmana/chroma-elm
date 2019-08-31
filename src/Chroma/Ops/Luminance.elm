module Chroma.Ops.Luminance exposing (luminance, contrast, setLuminance)

{-| Get/Set the luminance a color value and calculate the WCAG contrast ratio.


# Definition

@docs luminance, contrast, setLuminance

-}

import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Misc.ColorSpace as ColorSpace
import Chroma.Converter.Out.ToRgba as ToRgba
import Chroma.Interpolator as Interpolator
import Chroma.Types as Types


{-| Luminance
-}
luminance : Types.ExtColor -> Float
luminance color =
    let
        { red, green, blue, alpha } =
            ToRgba.toRgba255 color

        calcLuminance a =
            let
                newA =
                    toFloat a / 255
            in
            if newA <= 0.03928 then
                newA / 12.92

            else
                ((newA + 0.055) / 1.055) ^ 2.4
    in
    (calcLuminance red * 0.2126) + (calcLuminance green * 0.7152) + (calcLuminance blue * 0.0722)


{-| WCAG Contrast
-}
contrast : Types.ExtColor -> Types.ExtColor -> Float
contrast color1 color2 =
    let
        l1 =
            luminance color1

        l2 =
            luminance color2
    in
    if l1 > l2 then
        (l1 + 0.05) / (l2 + 0.05)

    else
        (l2 + 0.05) / (l1 + 0.05)


{-| Set Luminance
-}
setLuminance : Types.ExtColor -> Float -> Types.ExtColor
setLuminance color lum =
    let
        maxIteration =
            40

        currentLuminance =
            luminance color
    in
    if lum == 0 then
        Types.RGBAColor W3CX11.white

    else if lum == 1 then
        Types.RGBAColor W3CX11.black

    else if currentLuminance > lum then
        testLuminance maxIteration lum (Types.RGBAColor W3CX11.black) color

    else
        testLuminance maxIteration lum color (Types.RGBAColor W3CX11.white)


testLuminance : Int -> Float -> Types.ExtColor -> Types.ExtColor -> Types.ExtColor
testLuminance iter currentLuminance low high =
    let
        eps =
            1.0e-10

        mid =
            Interpolator.interpolate (ColorSpace.colorConvert Types.RGBA low) (ColorSpace.colorConvert Types.RGBA high) 0.5

        newLuminance =
            mid |> luminance

        exit =
            iter == 0 || abs (currentLuminance - newLuminance) < eps
    in
    if exit then
        mid

    else if newLuminance > currentLuminance then
        testLuminance (iter - 1) currentLuminance low mid

    else
        testLuminance (iter - 1) currentLuminance mid high
