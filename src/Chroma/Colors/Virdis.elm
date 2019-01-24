module Chroma.Colors.Virdis exposing (virdis)

{-| The objectively, best color scheme (Somewhere Over the Rainbow: An Empirical Assessmentof Quantitative Colormaps <https://idl.cs.washington.edu/files/2018-QuantitativeColor-CHI.pdf>)


# Colour Ramp

@docs virdis

-}

import Color exposing (Color, rgb255)
import List.Nonempty as Nonempty


virdis : Nonempty.Nonempty Color
virdis =
    Nonempty.Nonempty (rgb255 68 1 84)
        [ rgb255 72 21 103
        , rgb255 72 38 119
        , rgb255 69 55 129
        , rgb255 64 71 136
        , rgb255 57 86 140
        , rgb255 51 99 141
        , rgb255 45 112 142
        , rgb255 40 125 142
        , rgb255 35 138 141
        , rgb255 31 150 139
        , rgb255 32 163 135
        , rgb255 41 175 127
        , rgb255 60 187 117
        , rgb255 85 193 103
        , rgb255 115 208 85
        , rgb255 149 216 64
        , rgb255 184 222 41
        , rgb255 220 227 25
        , rgb255 253 231 37
        ]
