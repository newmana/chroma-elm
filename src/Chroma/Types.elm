module Chroma.Types exposing (CymkColor, ExtColor(..), HslaColor, HslaDegreesColor, LabColor, Mode(..), Rgba255Color, RgbaColor, LchColor)

{-| Types


# Definition

@docs CymkColor, ExtColor, HslaColor, HslaDegreesColor, LabColor, Mode, Rgba255Color, RgbaColor, LchColor

-}

import Color


{-| Possible color spaces.
-}
type Mode
    = RGBA
    | CMYK
    | LAB
    | LCH
    | HSLA
    | HSLADegrees


{-| Type wrapping possible color spaces.
-}
type ExtColor
    = RGBAColor Color.Color
    | CMYKColor CymkColor
    | LABColor LabColor
    | LCHColor LchColor
    | HSLAColor HslaColor
    | HSLADegreesColor HslaDegreesColor


{-| [`LAB color space`](https://en.wikipedia.org/wiki/CIELAB_color_space)
-}
type alias LabColor =
    { lightness : Float
    , labA : Float
    , labB : Float
    }


{-| ['CMYK color space'](https://en.wikipedia.org/wiki/CMYK_color_model)
-}
type alias CymkColor =
    { cyan : Float
    , magenta : Float
    , yellow : Float
    , black : Float
    }


{-| RGBA color space where numbers are RGB and Alpha 0..1.
-}
type alias RgbaColor =
    { red : Float
    , green : Float
    , blue : Float
    , alpha : Float
    }


{-| RGBA color space where numbers are RGB are 1-255, and Alpha 0..1.
-}
type alias Rgba255Color =
    { red : Int
    , green : Int
    , blue : Int
    , alpha : Float
    }


{-| HSLA where the Hue, Saturation, Lightness and Alpha 0..1.
-}
type alias HslaColor =
    { hue : Float
    , saturation : Float
    , lightness : Float
    , alpha : Float
    }


{-| HSLA where the Hue is 0..360, ann Saturation, Lightness and Alpha 0..1.
-}
type alias HslaDegreesColor =
    { hueDegrees : Float
    , saturation : Float
    , lightness : Float
    , alpha : Float
    }


{-| LCH where Luminance is 0..100, Chroma is 0..230, and Hue is 0..360.
-}
type alias LchColor =
    { luminance : Float
    , chroma : Float
    , hue : Float
    }
