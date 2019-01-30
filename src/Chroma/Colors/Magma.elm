module Chroma.Colors.Magma exposing (magma)

{-| Magma colour scale.

![Magma](<https://raw.githubusercontent.com/newmana/chroma-elm/master/images/magma.png> =250x)


# Colour Scale

@docs magma

-}

import Color exposing (Color, rgb255)
import List.Nonempty as Nonempty


{-| TBD
-}
magma : Nonempty.Nonempty Color
magma =
    Nonempty.Nonempty (rgb255 0 0 4)
        [ rgb255 9 7 32
        , rgb255 26 16 66
        , rgb255 49 17 101
        , rgb255 74 16 121
        , rgb255 98 25 128
        , rgb255 121 34 130
        , rgb255 145 43 129
        , rgb255 170 51 125
        , rgb255 194 59 117
        , rgb255 217 70 107
        , rgb255 236 88 96
        , rgb255 247 114 92
        , rgb255 252 142 100
        , rgb255 254 170 116
        , rgb255 254 198 138
        , rgb255 253 226 163
        , rgb255 252 253 191
        ]
