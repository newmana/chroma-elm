module Scale
    exposing
        ( domain
        , gamma
        , correctLightness
        , padding
        , colorsNum
        , colorsFormat
        , classes
        , classesArray
        )

import Color


type alias Data =
    { mode : String
    , nanColor : Color
    , spread : Float
    , fixed : Bool
    , domain : List Float
    , pos : List Float
    , padding : List Float
    , classes : Bool
    , colors : List Color
    , out : Bool
    , min : Float
    , max : Float
    , correctLightness : Bool
    , gamma : Float
    }


defaultData =
    { mode = "rgb"
    , nanColor = rgb 204 204 204
    , spread = 0
    , fixed = false
    , domain = [ 0, 1 ]
    , pos = []
    , padding = [ 0, 0 ]
    , classes = false
    , colors = []
    , out = false
    , min = 0
    , max = 1
    , correctLightness = false
    , gamma = 1
    }



-- chroma.scale('#{colorbrewer_scale_name}').colors(#{num_bins})
-- chroma.scale(colour).domain([1, 100000], 7, 'log');
-- mode is equidistant, log, k-means or quantile


domain : List Float -> Int -> String -> List b
domain data bins mode =
    []


gamma : List Color.Color -> List Color.Color
gamma f =
    []


correctLightness : List Color.Color -> List Color.Color
correctLightness colors =
    []


padding : List Color.Color -> Float -> List Color.Color
padding colors f =
    []


colorsNum : List Color.Color -> Int -> List Color.Color
colorsNum colors num =
    colorsFormat colors "hex" num


colorsFormat : List Color.Color -> String -> Int -> List Color.Color
colorsFormat colors format num =
    []


classes : List Color.Color -> Int -> List Color.Color
classes colors num =
    []


classesArray : List Color.Color -> List Float -> List Color.Color
classesArray colors arr =
    []
