module Chroma.Types exposing (CymkColor, ExtColor(..), Hsla, LabColor, Mode(..), Rgba255Color, RgbaColor, asNonEmptyList)

{-| Types


# Definition

@docs CymkColor, ExtColor, Hsla, LabColor, Mode, Rgba255Color, RgbaColor, asNonEmptyList

-}

import Color as Color
import List.Nonempty as Nonempty


{-| TBD
-}
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


{-| TBD
-}
type ExtColor
    = ExtColor Color.Color
    | CMYKColor CymkColor
    | LABColor LabColor


{-| TBD
-}
type alias LabColor =
    { lightness : Float
    , labA : Float
    , labB : Float
    }


{-| TBD
-}
type alias CymkColor =
    { cyan : Float
    , magenta : Float
    , yellow : Float
    , black : Float
    }


{-| TBD
-}
type alias RgbaColor =
    { red : Float
    , green : Float
    , blue : Float
    , alpha : Float
    }


{-| TBD
-}
type alias Rgba255Color =
    { red : Int
    , green : Int
    , blue : Int
    , alpha : Float
    }


{-| TBD
-}
type alias Hsla =
    { hue : Float
    , saturation : Float
    , lightness : Float
    , alpha : Float
    }


{-| TBD
-}
asNonEmptyList : ExtColor -> Nonempty.Nonempty Float
asNonEmptyList color =
    case color of
        ExtColor c ->
            let
                { red, green, blue, alpha } =
                    Color.toRgba c
            in
            Nonempty.Nonempty red [ green, blue, alpha ]

        CMYKColor { cyan, magenta, yellow, black } ->
            Nonempty.Nonempty cyan [ magenta, yellow, black ]

        LABColor { lightness, labA, labB } ->
            Nonempty.Nonempty lightness [ labA, labB ]
