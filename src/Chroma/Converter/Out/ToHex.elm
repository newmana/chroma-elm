module Chroma.Converter.Out.ToHex exposing (toHex)

{-| Convert ExtColors to hex string (#RGB)


# Definition

@docs toHex

-}

import Chroma.Converter.Out.ToRgb as ToRgb
import Chroma.Types as Types
import Hex as Hex


{-| Takes a result from getColor and returns Integer (0-255) RGB values.
-}
toHex : Types.ExtColor -> String
toHex color =
    let
        { red, green, blue, alpha } =
            ToRgb.toRgba255 color
    in
    "#" ++ toPaddedHex red ++ toPaddedHex green ++ toPaddedHex blue


toPaddedHex : Int -> String
toPaddedHex color =
    let
        colourString =
            Hex.toString color
    in
    if String.length colourString == 1 then
        "0" ++ colourString

    else
        colourString
