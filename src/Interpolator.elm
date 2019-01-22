module Interpolator exposing (interpolate)

import Color as Color
import Types as Types


interpolate : Types.ExtColor -> Types.ExtColor -> Float -> Types.ExtColor
interpolate col1 col2 f =
    case ( col1, col2 ) of
        ( Types.ExtColor color1, Types.ExtColor color2 ) ->
            interpolateRGB color1 color2 f

        ( Types.LABColor l1 a1 b1, Types.LABColor l2 a2 b2 ) ->
            interpolateLAB { lightness = l1, labA = a1, labB = b1 } { lightness = l2, labA = a2, labB = b2 } f

        _ ->
            Debug.todo "CMYK not implemented."


interpolateRGB : Color.Color -> Color.Color -> Float -> Types.ExtColor
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
    Color.rgb r g b |> Types.ExtColor


interpolateLAB : { lightness : Float, labA : Float, labB : Float } -> { lightness : Float, labA : Float, labB : Float } -> Float -> Types.ExtColor
interpolateLAB color1 color2 f =
    Types.LABColor
        (color1.lightness + f * (color2.lightness - color1.lightness))
        (color1.labA + f * (color2.labA - color1.labA))
        (color1.labB + f * (color2.labB - color1.labB))
