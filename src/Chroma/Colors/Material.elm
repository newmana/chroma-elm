module Chroma.Colors.Material exposing (red, pink, purple, deepPurple, indigo, blue, lightBlue, cyan, teal, green, lightGreen, lime, yellow, amber, orange, deepOrange, brown, gray, blueGray)

{-| [Material 2014 Colours](https://material.io/design/color/the-color-system.html#tools-for-picking-colors)


# Palettes

@docs red, pink, purple, deepPurple, indigo, blue, lightBlue, cyan, teal, green, lightGreen, lime, yellow, amber, orange, deepOrange, brown, gray, blueGray

-}

import Color exposing (Color, rgb255)
import List.Nonempty as Nonempty


{-| TBD
-}
red : Nonempty.Nonempty Color
red =
    Nonempty.Nonempty (rgb255 255 235 238)
        [ rgb255 255 205 210
        , rgb255 239 154 154
        , rgb255 229 115 115
        , rgb255 239 83 80
        , rgb255 244 67 54
        , rgb255 229 57 53
        , rgb255 211 47 47
        , rgb255 198 40 40
        , rgb255 183 28 28
        , rgb255 255 138 128
        , rgb255 255 82 82
        , rgb255 255 23 68
        , rgb255 213 0 0
        ]


{-| TBD
-}
pink : Nonempty.Nonempty Color
pink =
    Nonempty.Nonempty (rgb255 252 228 236)
        [ rgb255 248 187 208
        , rgb255 244 143 177
        , rgb255 240 98 146
        , rgb255 236 64 122
        , rgb255 233 30 99
        , rgb255 216 27 96
        , rgb255 194 24 91
        , rgb255 173 20 87
        , rgb255 136 14 79
        , rgb255 255 128 171
        , rgb255 255 64 129
        , rgb255 245 0 87
        , rgb255 197 17 98
        ]


{-| TBD
-}
purple : Nonempty.Nonempty Color
purple =
    Nonempty.Nonempty (rgb255 243 229 245)
        [ rgb255 225 190 231
        , rgb255 206 147 216
        , rgb255 186 104 200
        , rgb255 171 71 188
        , rgb255 156 39 176
        , rgb255 142 36 170
        , rgb255 123 31 162
        , rgb255 106 27 154
        , rgb255 74 20 140
        , rgb255 234 128 252
        , rgb255 224 64 251
        , rgb255 213 0 249
        , rgb255 170 0 255
        ]


{-| TBD
-}
deepPurple : Nonempty.Nonempty Color
deepPurple =
    Nonempty.Nonempty (rgb255 237 231 246)
        [ rgb255 209 196 233
        , rgb255 179 157 219
        , rgb255 149 117 205
        , rgb255 126 87 194
        , rgb255 103 58 183
        , rgb255 94 53 177
        , rgb255 81 45 168
        , rgb255 69 39 160
        , rgb255 49 27 146
        , rgb255 179 136 255
        , rgb255 124 77 255
        , rgb255 101 31 255
        , rgb255 98 0 234
        ]


{-| TBD
-}
indigo : Nonempty.Nonempty Color
indigo =
    Nonempty.Nonempty (rgb255 232 234 246)
        [ rgb255 197 202 233
        , rgb255 159 168 218
        , rgb255 121 134 203
        , rgb255 92 107 192
        , rgb255 63 81 181
        , rgb255 57 73 171
        , rgb255 48 63 159
        , rgb255 40 53 147
        , rgb255 26 35 126
        , rgb255 140 158 255
        , rgb255 83 109 254
        , rgb255 61 90 254
        , rgb255 48 79 254
        ]


{-| TBD
-}
blue : Nonempty.Nonempty Color
blue =
    Nonempty.Nonempty (rgb255 227 242 253)
        [ rgb255 187 222 251
        , rgb255 144 202 249
        , rgb255 100 181 246
        , rgb255 66 165 245
        , rgb255 33 150 243
        , rgb255 30 136 229
        , rgb255 25 118 210
        , rgb255 21 101 192
        , rgb255 13 71 161
        , rgb255 130 177 255
        , rgb255 68 138 255
        , rgb255 41 121 255
        , rgb255 41 98 255
        ]


{-| TBD
-}
lightBlue : Nonempty.Nonempty Color
lightBlue =
    Nonempty.Nonempty (rgb255 225 245 254)
        [ rgb255 179 229 252
        , rgb255 129 212 250
        , rgb255 79 195 247
        , rgb255 41 182 246
        , rgb255 3 169 244
        , rgb255 3 155 229
        , rgb255 2 136 209
        , rgb255 2 119 189
        , rgb255 1 87 155
        , rgb255 128 216 255
        , rgb255 64 196 255
        , rgb255 0 176 255
        , rgb255 0 145 234
        ]


{-| TBD
-}
cyan : Nonempty.Nonempty Color
cyan =
    Nonempty.Nonempty (rgb255 224 247 250)
        [ rgb255 178 235 242
        , rgb255 128 222 234
        , rgb255 77 208 225
        , rgb255 38 198 218
        , rgb255 0 188 212
        , rgb255 0 172 193
        , rgb255 0 151 167
        , rgb255 0 131 143
        , rgb255 0 96 100
        , rgb255 132 255 255
        , rgb255 24 255 255
        , rgb255 0 229 255
        , rgb255 0 184 212
        ]


{-| TBD
-}
teal : Nonempty.Nonempty Color
teal =
    Nonempty.Nonempty (rgb255 224 242 241)
        [ rgb255 178 223 219
        , rgb255 128 203 196
        , rgb255 77 182 172
        , rgb255 38 166 154
        , rgb255 0 150 136
        , rgb255 0 137 123
        , rgb255 0 121 107
        , rgb255 0 105 92
        , rgb255 0 77 64
        , rgb255 167 255 235
        , rgb255 100 255 218
        , rgb255 29 233 182
        , rgb255 0 191 165
        ]


{-| TBD
-}
green : Nonempty.Nonempty Color
green =
    Nonempty.Nonempty (rgb255 232 245 233)
        [ rgb255 200 230 201
        , rgb255 165 214 167
        , rgb255 129 199 132
        , rgb255 102 187 106
        , rgb255 76 175 80
        , rgb255 67 160 71
        , rgb255 56 142 60
        , rgb255 46 125 50
        , rgb255 27 94 32
        , rgb255 185 246 202
        , rgb255 105 240 174
        , rgb255 0 230 118
        , rgb255 0 200 83
        ]


{-| TBD
-}
lightGreen : Nonempty.Nonempty Color
lightGreen =
    Nonempty.Nonempty (rgb255 241 248 233)
        [ rgb255 220 237 200
        , rgb255 197 225 165
        , rgb255 174 213 129
        , rgb255 156 204 101
        , rgb255 139 195 74
        , rgb255 124 179 66
        , rgb255 104 159 56
        , rgb255 85 139 47
        , rgb255 51 105 30
        , rgb255 204 255 144
        , rgb255 178 255 89
        , rgb255 118 255 3
        , rgb255 100 221 23
        ]


{-| TBD
-}
lime : Nonempty.Nonempty Color
lime =
    Nonempty.Nonempty (rgb255 249 251 231)
        [ rgb255 240 244 195
        , rgb255 230 238 156
        , rgb255 220 231 117
        , rgb255 212 225 87
        , rgb255 205 220 57
        , rgb255 192 202 51
        , rgb255 175 180 43
        , rgb255 158 157 36
        , rgb255 130 119 23
        , rgb255 244 255 129
        , rgb255 238 255 65
        , rgb255 198 255 0
        , rgb255 174 234 0
        ]


{-| TBD
-}
yellow : Nonempty.Nonempty Color
yellow =
    Nonempty.Nonempty (rgb255 255 253 231)
        [ rgb255 255 249 196
        , rgb255 255 245 157
        , rgb255 255 241 118
        , rgb255 255 238 88
        , rgb255 255 235 59
        , rgb255 253 216 53
        , rgb255 251 192 45
        , rgb255 249 168 37
        , rgb255 245 127 23
        , rgb255 255 255 141
        , rgb255 255 255 0
        , rgb255 255 234 0
        , rgb255 255 214 0
        ]


{-| TBD
-}
amber : Nonempty.Nonempty Color
amber =
    Nonempty.Nonempty (rgb255 255 248 225)
        [ rgb255 255 236 179
        , rgb255 255 224 130
        , rgb255 255 213 79
        , rgb255 255 202 40
        , rgb255 255 193 7
        , rgb255 255 179 0
        , rgb255 255 160 0
        , rgb255 255 143 0
        , rgb255 255 143 0
        , rgb255 255 229 127
        , rgb255 255 215 64
        , rgb255 255 196 0
        , rgb255 255 171 0
        ]


{-| TBD
-}
orange : Nonempty.Nonempty Color
orange =
    Nonempty.Nonempty (rgb255 255 243 224)
        [ rgb255 255 224 178
        , rgb255 255 204 128
        , rgb255 255 183 77
        , rgb255 255 167 38
        , rgb255 255 152 0
        , rgb255 251 140 0
        , rgb255 245 124 0
        , rgb255 239 108 0
        , rgb255 230 81 0
        , rgb255 255 209 128
        , rgb255 255 171 64
        , rgb255 255 145 0
        , rgb255 255 109 0
        ]


{-| TBD
-}
deepOrange : Nonempty.Nonempty Color
deepOrange =
    Nonempty.Nonempty (rgb255 251 233 231)
        [ rgb255 255 204 188
        , rgb255 255 171 145
        , rgb255 255 138 101
        , rgb255 255 112 67
        , rgb255 255 87 34
        , rgb255 244 81 30
        , rgb255 230 74 25
        , rgb255 216 67 21
        , rgb255 191 54 12
        , rgb255 255 158 128
        , rgb255 255 110 64
        , rgb255 255 61 0
        , rgb255 221 44 0
        ]


{-| TBD
-}
brown : Nonempty.Nonempty Color
brown =
    Nonempty.Nonempty (rgb255 239 235 233)
        [ rgb255 215 204 200
        , rgb255 188 170 164
        , rgb255 161 136 127
        , rgb255 141 110 99
        , rgb255 121 85 72
        , rgb255 109 76 65
        , rgb255 93 64 55
        , rgb255 78 52 46
        , rgb255 62 39 35
        ]


{-| TBD
-}
gray : Nonempty.Nonempty Color
gray =
    Nonempty.Nonempty (rgb255 250 250 250)
        [ rgb255 245 245 245
        , rgb255 238 238 238
        , rgb255 224 224 224
        , rgb255 189 189 189
        , rgb255 158 158 158
        , rgb255 117 117 117
        , rgb255 97 97 97
        , rgb255 66 66 66
        , rgb255 33 33 33
        ]


{-| TBD
-}
blueGray : Nonempty.Nonempty Color
blueGray =
    Nonempty.Nonempty (rgb255 236 239 241)
        [ rgb255 207 216 220
        , rgb255 176 190 197
        , rgb255 144 164 174
        , rgb255 120 144 156
        , rgb255 96 125 139
        , rgb255 84 110 122
        , rgb255 69 90 100
        , rgb255 55 71 79
        , rgb255 38 50 56
        ]
