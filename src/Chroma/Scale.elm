module Chroma.Scale exposing
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
    , getColor
    )

import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.In.Cmyk2Rgb as Cymk2Rgb
import Chroma.Converter.In.Lab2Rgb as Lab2Rgb
import Chroma.Interpolator as Interpolator
import Chroma.Types as Types
import Color as Color
import List.Nonempty as Nonempty


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


createData : Nonempty.Nonempty Types.ExtColor -> Data -> Data
createData newColors data =
    let
        ensureTwoColors =
            if Nonempty.length newColors == 1 then
                Nonempty.cons (Nonempty.head newColors) newColors

            else
                newColors
    in
    { data | pos = createPos newColors, colors = ensureTwoColors }


asRgba : Types.ExtColor -> Types.RgbaColor
asRgba color =
    case color of
        Types.ExtColor c ->
            Color.toRgba c

        Types.CMYKColor cmyk ->
            Cymk2Rgb.cmyk2rgb cmyk |> Color.toRgba

        Types.LABColor lab ->
            Lab2Rgb.lab2rgb lab |> Color.toRgba


{-| Finish <https://github.com/gka/chroma.js/blob/master/src/generator/scale.js#L119> >
Implement classes <https://github.com/gka/chroma.js/blob/master/src/generator/scale.js#L156>
-}
getColor : Data -> Float -> Types.ExtColor
getColor ({ mode, nanColor, spread, isFixed, domainValues, pos, paddingValues, useClasses, colors, useOut, min, max, useCorrectLightness, gammaValue } as data) val =
    let
        startT =
            (val - min) / (max - min)

        paddingValuesHead =
            Nonempty.head paddingValues

        lightnessCorrectedT =
            if useCorrectLightness then
                correctLightness { data | useCorrectLightness = False } startT

            else
                startT

        gammaT =
            lightnessCorrectedT ^ gammaValue

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


createDomainPos : Float -> Float -> Nonempty.Nonempty Float -> Nonempty.Nonempty ( Float, Float )
createDomainPos min max newDomain =
    let
        newDenom =
            max - min

        nonEmptyTail =
            case Nonempty.tail newDomain of
                [] ->
                    Debug.todo "Should not happen"

                h :: r ->
                    Nonempty.Nonempty h r

        pairUp =
            Nonempty.zip newDomain nonEmptyTail

        newPos =
            Nonempty.indexedMap (\i ( d1, d2 ) -> ( d1 - min / newDenom, d2 - min / newDenom )) pairUp
    in
    newPos


domain : Nonempty.Nonempty Float -> Data -> Data
domain newDomain data =
    let
        ( newMin, newMax ) =
            ( Nonempty.head newDomain, Nonempty.get (Nonempty.length newDomain - 1) newDomain )

        newPos =
            if Nonempty.length newDomain == Nonempty.length data.colors && newMin /= newMax then
                createDomainPos newMin newMax newDomain

            else
                createPos data.colors
    in
    { data | domainValues = Nonempty.Nonempty newMin [ newMax ], pos = newPos, min = newMin, max = newMax }


type alias Convergence =
    { diff : Float
    , t : Float
    , t0 : Float
    , t1 : Float
    }


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

        allResults =
            convergeResult data 20 pol ideal { diff = diff, t = val, t0 = 0, t1 = 1 }
    in
    allResults.t


convergeResult : Data -> Int -> Bool -> Float -> Convergence -> Convergence
convergeResult data maxIter pol ideal calcs =
    if (abs calcs.diff <= 0.01) || maxIter <= 0 then
        calcs

    else
        let
            result =
                calcResult data pol ideal calcs
        in
        convergeResult data (maxIter - 1) pol ideal result


calcResult : Data -> Bool -> Float -> Convergence -> Convergence
calcResult data pol ideal calcs =
    let
        newCalcs =
            if pol then
                { calcs | diff = calcs.diff * -1 }

            else
                calcs

        ( newT, newT0, newT1 ) =
            if newCalcs.diff < 0 then
                ( newCalcs.t + ((newCalcs.t1 - newCalcs.t) * 0.5), newCalcs.t, newCalcs.t1 )

            else
                ( newCalcs.t + ((newCalcs.t0 - newCalcs.t) * 0.5), newCalcs.t0, newCalcs.t )

        actual =
            getColor data newT |> Types.asNonEmptyList |> Nonempty.head
    in
    { diff = actual - ideal, t = newT, t0 = newT0, t1 = newT1 }


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
