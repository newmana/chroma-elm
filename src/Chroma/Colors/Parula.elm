module Chroma.Colors.Parula exposing (parula)

{-| Parula color scale.

![Parula](https://raw.githubusercontent.com/newmana/chroma-elm/master/images/parula4.png)


# Color Scale

@docs parula

-}

import Color exposing (Color, rgb255)
import List.Nonempty as Nonempty


{-| TBD
-}
parula : Nonempty.Nonempty Color
parula =
    Nonempty.Nonempty (rgb255 53 42 135)
        [ rgb255 53 61 173
        , rgb255 32 83 212
        , rgb255 2 104 225
        , rgb255 13 117 220
        , rgb255 20 129 214
        , rgb255 16 142 210
        , rgb255 7 156 207
        , rgb255 6 167 198
        , rgb255 15 174 185
        , rgb255 37 181 169
        , rgb255 66 187 152
        , rgb255 101 190 134
        , rgb255 135 191 119
        , rgb255 165 190 107
        , rgb255 192 188 96
        , rgb255 217 186 86
        , rgb255 241 185 74
        , rgb255 255 195 55
        , rgb255 250 211 42
        , rgb255 245 228 29
        , rgb255 249 251 14
        ]
