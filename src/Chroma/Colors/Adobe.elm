module Chroma.Colors.Adobe exposing
    ( rose, cerulean, forest
    , color6, color12
    )

{-| [Color for data visualization](https://spectrum.adobe.com/page/color-for-data-visualization/)


# Sequential Multi-hue Color Map

@docs rose, cerulean, forest


# Qualitative Color Ramp

@docs color6, color12

-}

import Color exposing (Color, rgb255)
import List.Nonempty as Nonempty



-- Sequential Multi-Hue


{-| TBD
-}
rose : Nonempty.Nonempty Color
rose =
    Nonempty.Nonempty (rgb255 254 246 227)
        [ rgb255 250 226 221
        , rgb255 247 206 215
        , rgb255 243 186 208
        , rgb255 237 165 201
        , rgb255 231 143 194
        , rgb255 224 119 186
        , rgb255 217 92 178
        , rgb255 198 78 167
        , rgb255 180 67 156
        , rgb255 159 55 147
        , rgb255 136 45 138
        , rgb255 113 36 130
        , rgb255 88 27 122
        , rgb255 57 20 116
        , rgb255 1 15 110
        ]


{-| TBD
-}
cerulean : Nonempty.Nonempty Color
cerulean =
    Nonempty.Nonempty (rgb255 238 255 242)
        [ rgb255 207 243 232
        , rgb255 175 232 220
        , rgb255 143 219 209
        , rgb255 118 205 200
        , rgb255 98 189 193
        , rgb255 76 172 187
        , rgb255 51 156 181
        , rgb255 43 140 171
        , rgb255 39 122 162
        , rgb255 36 104 152
        , rgb255 31 87 142
        , rgb255 31 68 132
        , rgb255 28 48 123
        , rgb255 27 23 110
        , rgb255 25 1 97
        ]


{-| TBD
-}
forest : Nonempty.Nonempty Color
forest =
    Nonempty.Nonempty (rgb255 255 255 227)
        [ rgb255 230 247 195
        , rgb255 205 237 160
        , rgb255 175 227 121
        , rgb255 154 215 116
        , rgb255 134 203 108
        , rgb255 108 190 101
        , rgb255 87 176 95
        , rgb255 68 162 90
        , rgb255 53 148 87
        , rgb255 43 133 85
        , rgb255 32 118 81
        , rgb255 20 103 79
        , rgb255 13 87 75
        , rgb255 6 72 72
        , rgb255 0 56 67
        ]



-- Qualitative


{-| TBD
-}
color6 : Nonempty.Nonempty Color
color6 =
    Nonempty.take 6 color12


{-| TBD
-}
color12 : Nonempty.Nonempty Color
color12 =
    Nonempty.Nonempty (rgb255 17 181 174)
        [ rgb255 64 70 202
        , rgb255 246 133 18
        , rgb255 222 60 130
        , rgb255 126 132 250
        , rgb255 114 225 106
        , rgb255 22 122 243
        , rgb255 115 38 211
        , rgb255 232 198 0
        , rgb255 203 93 2
        , rgb255 3 143 93
        , rgb255 188 233 49
        ]
