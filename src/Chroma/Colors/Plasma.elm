module Chroma.Colors.Plasma exposing (plasma)

{-| Plasma color scale.


# Color Scale

@docs plasma

-}

import Color exposing (Color, rgb255)
import List.Nonempty as Nonempty


{-| TBD
-}
plasma : Nonempty.Nonempty Color
plasma =
    Nonempty.Nonempty (rgb255 13 8 135)
        [ rgb255 47 5 150
        , rgb255 73 3 160
        , rgb255 97 0 167
        , rgb255 120 1 168
        , rgb255 142 12 164
        , rgb255 162 29 154
        , rgb255 180 46 141
        , rgb255 196 62 127
        , rgb255 210 79 113
        , rgb255 222 97 100
        , rgb255 233 114 87
        , rgb255 243 133 75
        , rgb255 249 154 62
        , rgb255 253 175 49
        , rgb255 253 198 39
        , rgb255 248 223 37
        , rgb255 240 249 33
        ]
