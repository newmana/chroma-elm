module Scale exposing
    ( Data
    , classes
    , classesArray
    , colorsFormat
    , colorsNum
    , correctLightness
    , defaultData
    , domain
    , gamma
    , padding
    )

import Color as Color
import Colors.W3CX11 as W3CX11
import Debug
import List.Nonempty as Nonempty
import Types as Types


type alias Data =
    { mode : Types.Mode
    , nanColor : Color.Color
    , spread : Float
    , isFixed : Bool
    , domainValues : Nonempty.Nonempty Float
    , pos : List Float
    , paddingValues : Nonempty.Nonempty Float
    , useClasses : Bool
    , colors : List Color.Color
    , useOut : Bool
    , min : Float
    , max : Float
    , useCorrectLightness : Bool
    , gammaValue : Float
    }


defaultData : Data
defaultData =
    { mode = Types.RGB
    , nanColor = Color.rgb 204 204 204
    , spread = 0
    , isFixed = False
    , domainValues = Nonempty.append (Nonempty.fromElement 0) (Nonempty.fromElement 1)
    , pos = []
    , paddingValues = Nonempty.append (Nonempty.fromElement 0) (Nonempty.fromElement 0)
    , useClasses = False
    , colors = [ W3CX11.white, W3CX11.black ]
    , useOut = False
    , min = 0
    , max = 1
    , useCorrectLightness = False
    , gammaValue = 1
    }



-- chroma.scale('#{colorbrewer_scale_name}').colors(#{num_bins})
-- chroma.scale(colour).domain([1, 100000], 7, 'log');
-- mode is equidistant, log, k-means or quantile


setupData : Data -> Data
setupData oldData =
    let
        colLength =
            List.length oldData.colors |> toFloat

        newPos =
            List.indexedMap (\i _ -> toFloat i / colLength) oldData.colors
    in
    { oldData | pos = newPos }


getColor : Data -> Float -> Types.ExtColor
getColor { mode, nanColor, spread, isFixed, domainValues, pos, paddingValues, useClasses, colors, useOut, min, max, useCorrectLightness, gammaValue } val =
    let
        startT =
            (val - min) / (max - min)

        paddingValuesHead =
            Nonempty.head paddingValues

        paddedT =
            paddingValuesHead + (startT * (1 - paddingValuesHead - Nonempty.get 1 paddingValues))

        boundedT =
            Basics.min 1 (Basics.max 0 paddedT)
    in
    Types.ExtColor W3CX11.black


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
