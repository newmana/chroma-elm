module Scale exposing
    ( Data
    , classes
    , classesArray
    , colorsFormat
    , colorsNum
    , correctLightness
    , createData
    , createPos
    , defaultData
    , domain
    , gamma
    , getColor
    , padding
    )

import Color as Color
import Colors.W3CX11 as W3CX11
import Debug
import Interpolator as Interpolator
import List.Nonempty as Nonempty
import Types as Types


type alias Data =
    { mode : Types.Mode
    , nanColor : Color.Color
    , spread : Float
    , isFixed : Bool
    , domainValues : Nonempty.Nonempty Float
    , pos : Nonempty.Nonempty ( Float, Float )
    , paddingValues : Nonempty.Nonempty Float
    , useClasses : Bool
    , colors : Nonempty.Nonempty Types.ExtColor
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
    , domainValues = Nonempty.Nonempty 0 [ 1 ]
    , pos = Nonempty.fromElement ( 0, 1 )
    , paddingValues = Nonempty.Nonempty 0 [ 0 ]
    , useClasses = False
    , colors = Nonempty.Nonempty (Types.ExtColor W3CX11.white) [ Types.ExtColor W3CX11.black ]
    , useOut = False
    , min = 0
    , max = 1
    , useCorrectLightness = False
    , gammaValue = 1
    }



-- chroma.scale('#{colorbrewer_scale_name}').colors(#{num_bins})
-- chroma.scale(colour).domain([1, 100000], 7, 'log');
-- mode is equidistant, log, k-means or quantile


createPos : Nonempty.Nonempty Types.ExtColor -> Nonempty.Nonempty ( Float, Float )
createPos newColors =
    let
        colLength =
            Nonempty.length newColors - 1 |> toFloat

        newPos =
            Nonempty.indexedMap (\i _ -> ( toFloat i / colLength, toFloat (i + 1) / colLength )) newColors
    in
    newPos


createData : Data -> Nonempty.Nonempty Types.ExtColor -> Data
createData data newColors =
    let
        ensureTwoColors =
            if Nonempty.length newColors == 1 then
                Nonempty.cons (Nonempty.head newColors) newColors

            else
                newColors
    in
    { data | pos = createPos newColors, colors = ensureTwoColors }


{-| Implement lightness correction (before <https://github.com/gka/chroma.js/blob/master/src/generator/scale.js#L105>
Implemment domain <https://github.com/gka/chroma.js/blob/master/src/generator/scale.js#L175>
Implement classes <https://github.com/gka/chroma.js/blob/master/src/generator/scale.js#L156>
-}
getColor : Data -> Float -> Types.ExtColor
getColor { mode, nanColor, spread, isFixed, domainValues, pos, paddingValues, useClasses, colors, useOut, min, max, useCorrectLightness, gammaValue } val =
    let
        startT =
            (val - min) / (max - min)

        paddingValuesHead =
            Nonempty.head paddingValues

        gammaT =
            startT ^ gammaValue

        paddedT =
            paddingValuesHead + (gammaT * (1 - paddingValuesHead - Nonempty.get 1 paddingValues))

        boundedT =
            clamp 0 1 paddedT
    in
    if boundedT <= 0 then
        Nonempty.head colors

    else if boundedT >= 1 then
        Nonempty.get -1 colors

    else
        let
            ( t, finishedIndex, _ ) =
                Nonempty.foldl
                    (\( p0, p1 ) ( result, foundIndex, i ) ->
                        if boundedT > p0 && boundedT < p1 then
                            ( (boundedT - p0) / (p1 - p0), i, i + 1 )

                        else
                            ( result, foundIndex, i + 1 )
                    )
                    ( 0, 0, 0 )
                    pos
        in
        Interpolator.interpolate (Nonempty.get finishedIndex colors) (Nonempty.get (finishedIndex + 1) colors) t


domain : List Float -> Int -> String -> List b
domain data bins mode =
    []


gamma : List Color.Color -> List Color.Color
gamma f =
    []


correctLightness : Data -> Float -> Float
correctLightness data val =
    let
        l0 =
            getColor data 0 |> Types.asNonEmptyList |> Nonempty.head

        l1 =
            getColor data 1 |> Types.asNonEmptyList |> Nonempty.head

        pol =
            l0 > l1

        actual =
            getColor data val |> Types.asNonEmptyList |> Nonempty.head

        ideal =
            l0 + ((l1 - l0) * val)

        diff =
            actual - ideal
    in
    Debug.todo "Not Good"


doStuff data pol t t0 t1 diff ideal =
    let
        newLDiff =
            if pol then
                diff * -1

            else
                diff

        ( newT, newT0, newT1 ) =
            if diff < 0 then
                ( t + ((t1 - t) * 0.5), t, t1 )

            else
                ( t + ((t0 - t) * 0.5), t0, t )

        actual =
            getColor data newT |> Types.asNonEmptyList |> Nonempty.head
    in
    { diff = diff, t = newT, t0 = newT0, t1 = newT1 }


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
