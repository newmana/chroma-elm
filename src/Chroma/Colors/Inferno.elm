module Chroma.Colors.Inferno exposing (inferno)

{-| Inferno colour scale.

![Inferno](https://raw.githubusercontent.com/newmana/chroma-elm/master/images/inferno.png)


# Colour Scale

@docs inferno

-}

import Color exposing (Color, rgb255)
import List.Nonempty as Nonempty


{-| TBD
-}
inferno : Nonempty.Nonempty Color
inferno =
    Nonempty.Nonempty (rgb255 0 0 4)
        [ rgb255 10 7 34
        , rgb255 30 12 69
        , rgb255 56 9 98
        , rgb255 81 14 108
        , rgb255 105 22 110
        , rgb255 128 31 108
        , rgb255 152 39 102
        , rgb255 176 49 91
        , rgb255 198 61 77
        , rgb255 217 77 61
        , rgb255 233 97 43
        , rgb255 244 121 24
        , rgb255 250 148 7
        , rgb255 252 176 20
        , rgb255 248 205 55
        , rgb255 242 234 105
        , rgb255 252 255 164
        ]
