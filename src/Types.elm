module Types
    exposing
        ( Mode(..)
        , ExtColor(..)
        , asList
        )

import Color as Color


type Mode
    = CMYK
      --    | CSS
      --    | HEX
      --    | HSI
      --    | HSL
      --    | HSV
    | LAB
      --    | LCH
    | RGB



--    | NUM
--    | Temperature


type ExtColor
    = ExtColor Color.Color
    | CMYKColor Float Float Float Float
    | LABColor Float Float Float


asList : ExtColor -> List Float
asList color =
    case color of
        ExtColor c ->
            let
                { red, green, blue, alpha } =
                    Color.toRgb c
            in
                [ toFloat red, toFloat green, toFloat blue, alpha ]

        CMYKColor c m y k ->
            [ c, m, y, k ]

        LABColor l a b ->
            [ l, a, b ]
