module Chroma.Blend exposing (BlendMode(..), blend)

import Chroma.Converter.Out.ToRgba as ToRgba
import Chroma.Ops.Alpha as OpsAlpha
import Chroma.Types as Types
import Color as Color


{-| TBD
-}
type BlendMode
    = Normal
    | Multiply
    | Darken
    | Lighten
    | Screen
    | Overlay
    | Burn
    | Dodge
    | Exclusion


blend : BlendMode -> Types.ExtColor -> Types.ExtColor -> Types.ExtColor
blend mode colorExt1 colorExt2 =
    let
        color1 =
            ToRgba.toRgba colorExt1

        color2 =
            ToRgba.toRgba colorExt2

        newAlpha =
            color2.alpha + color1.alpha * (1 - color2.alpha)

        newColor c1 c2 =
            Color.rgb (colorF c1.red c2.red) (colorF c1.green c2.green) (colorF c1.blue c2.blue) |> Types.RGBAColor |> OpsAlpha.setAlpha newAlpha

        colorF a b =
            f a b |> clamp 0 1

        f =
            case mode of
                Normal ->
                    \a _ -> a

                Multiply ->
                    (*)

                Darken ->
                    \a b ->
                        if a > b then
                            b

                        else
                            a

                Lighten ->
                    \a b ->
                        if a > b then
                            a

                        else
                            b

                Screen ->
                    \a b ->
                        a + b - a * b

                Overlay ->
                    \a b ->
                        if a <= 0.5 then
                            2 * a * b

                        else
                            1 - (2 * (1 - a)) * (1 - b)

                Burn ->
                    \a b ->
                        1 - (1 - b) / a

                Dodge ->
                    \a b ->
                        if a == 1 then
                            1

                        else
                            b / (1 - a)

                Exclusion ->
                    \a b ->
                        a + b - (2 * a * b)
    in
    newColor color1 color2
