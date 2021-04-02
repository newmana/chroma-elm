module Chroma.Converter.Out.ToHex exposing (toHex, toHexAlpha)

{-| Convert ExtColors to hex string (#RGB) or hex string with alpha channel (#RGBA)


# Definition

@docs toHex, toHexAlpha

-}

import Chroma.Converter.Out.ToRgba as ToRgb
import Chroma.Types as Types
import Hex


{-| Takes a result from getColor and returns Integer (0-255) RGB values.
-}
toHex : Types.ExtColor -> String
toHex color =
    let
        { red, green, blue, alpha } =
            ToRgb.toRgba255 color
    in
    "#" ++ toPaddedHex red ++ toPaddedHex green ++ toPaddedHex blue


{-| Takes a result from getColor and returns Integer (0-255) RGB and alpha values.
-}
toHexAlpha : Types.ExtColor -> String
toHexAlpha color =
    let
        { red, green, blue, alpha } =
            ToRgb.toRgba255 color
    in
    "#" ++ toPaddedHex red ++ toPaddedHex green ++ toPaddedHex blue ++ toPaddedHex (round (255 * alpha))


toPaddedHex : Int -> String
toPaddedHex color =
    let
        colorString =
            Hex.toString color
    in
    if String.length colorString == 1 then
        "0" ++ colorString

    else
        colorString
