module Chroma.Converter.Out.ToCss exposing (toCss, toCssAlpha)

{-| Convert ExtColors to CSS string (#RGB) or CSS string with alpha channel (#RGBA)


# Definition

@docs toCss, toCssAlpha

-}

import Chroma.Converter.Out.ToRgba as ToRgb
import Chroma.Types as Types


{-| Returns an ExtColor as a RGB CSS string.
-}
toCss : Types.ExtColor -> String
toCss color =
    let
        { red, green, blue, alpha } =
            ToRgb.toRgba255 color
    in
    "rgb(" ++ mapCss [ red, green, blue ] ++ ")"


{-| Returns an ExtColor as a RGBA CSS string.
-}
toCssAlpha : Types.ExtColor -> String
toCssAlpha color =
    let
        { red, green, blue, alpha } =
            ToRgb.toRgba255 color
    in
    "rgba(" ++ mapCss [ red, green, blue ] ++ ", " ++ String.fromFloat alpha ++ ")"


mapCss : List Int -> String
mapCss values =
    List.map String.fromInt values |> String.join ", "
