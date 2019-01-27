module Chroma.Scale exposing (getColor, domain, correctLightness, Data, classes, createData, defaultData)

{-| The attempt here is to provide something similar to <https://gka.github.io/chroma.js/> but also idiomatic Elm.


# Definition

@docs getColor, domain, correctLightness, Data, classes, createData, defaultData

-}

import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.In.Cmyk2Rgb as Cymk2Rgb
import Chroma.Converter.In.Lab2Rgb as Lab2Rgb
import Chroma.Converter.Out.ToRgb as ToRgb
import Chroma.Interpolator as Interpolator
import Chroma.Types as Types
import Color as Color
import List.Nonempty as Nonempty


{-| Configuration data used by most functions.
-}
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


{-| Sensible default configuration defaults: RGB, domain 0-1, pos 0, 1,and white and black colour range.
-}
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
    , colors = Nonempty.Nonempty (Types.RGBColor W3CX11.white) [ Types.RGBColor W3CX11.black ]
    , useOut = False
    , min = 0
    , max = 1
    , useCorrectLightness = False
    , gammaValue = 1
    }



-- chroma.scale('#{colorbrewer_scale_name}').colors(#{num_bins})
-- chroma.scale(colour).domain([1, 100000], 7, 'log');
-- mode is equidistant, log, k-means or quantile


{-| Recalculate pos based on new colours.
-}
createPos : Nonempty.Nonempty Types.ExtColor -> Nonempty.Nonempty ( Float, Float )
createPos newColors =
    let
        colLength =
            Nonempty.length newColors - 1 |> toFloat

        newPos =
            Nonempty.indexedMap (\i _ -> ( toFloat i / colLength, toFloat (i + 1) / colLength )) newColors
    in
    newPos


{-| Setup new configuration with the given colours.
-}
createData : Nonempty.Nonempty Types.ExtColor -> Data -> Data
createData newColors data =
    let
        ensureTwoColors =
            if Nonempty.isSingleton newColors then
                Nonempty.cons (Nonempty.head newColors) newColors

            else
                newColors
    in
    { data | pos = createPos newColors, colors = ensureTwoColors }


{-| Finish <https://github.com/gka/chroma.js/blob/master/src/generator/scale.js#L119> >
Implement classes <https://github.com/gka/chroma.js/blob/master/src/generator/scale.js#L156>
-}
getColor : Data -> Float -> Types.ExtColor
getColor data val =
    getDirectColor data ((val - data.min) / (data.max - data.min))


getDirectColor : Data -> Float -> Types.ExtColor
getDirectColor ({ mode, nanColor, spread, isFixed, domainValues, pos, paddingValues, useClasses, colors, useOut, min, max, useCorrectLightness, gammaValue } as data) startT =
    let
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

        posMax =
            Nonempty.length pos - 1

        ( _, finalResult, _ ) =
            Nonempty.foldl
                (\( p0, p1 ) ( found, result, i ) ->
                    if not found then
                        if (boundedT <= p0) || (boundedT >= p0 && i == posMax) then
                            ( True, Nonempty.get i colors, i )

                        else if boundedT > p0 && boundedT < p1 then
                            let
                                newT =
                                    (boundedT - p0) / (p1 - p0)

                                interT =
                                    Interpolator.interpolate (Nonempty.get i colors) (Nonempty.get (i + 1) colors) newT
                            in
                            ( True, interT, i )

                        else
                            ( found, result, i + 1 )

                    else
                        ( found, result, i + 1 )
                )
                ( False, Types.RGBColor W3CX11.black, 0 )
                pos
    in
    finalResult


createDomainPos : Nonempty.Nonempty ( Float, Float ) -> Float -> Float -> Nonempty.Nonempty Float -> Nonempty.Nonempty ( Float, Float )
createDomainPos oldPos min max newDomain =
    let
        newDenom =
            max - min

        maybeNonEmptyTail =
            case Nonempty.tail newDomain of
                [] ->
                    Nothing

                h :: r ->
                    Just (Nonempty.Nonempty h r)

        pairUp =
            case maybeNonEmptyTail of
                Nothing ->
                    oldPos

                Just nonEmptyTail ->
                    Nonempty.zip newDomain nonEmptyTail

        newPos =
            Nonempty.indexedMap (\i ( d1, d2 ) -> ( d1 - min / newDenom, d2 - min / newDenom )) pairUp
    in
    newPos


{-| Set a new domain like [0,100] rather than the default [0,1]
-}
domain : Nonempty.Nonempty Float -> Data -> Data
domain newDomain data =
    let
        ( newMin, newMax ) =
            ( Nonempty.head newDomain, Nonempty.get (Nonempty.length newDomain - 1) newDomain )

        newPos =
            if Nonempty.length newDomain == Nonempty.length data.colors && newMin /= newMax then
                createDomainPos data.pos newMin newMax newDomain

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


{-| Given a data change the lightness value (need to be LAB).
-}
correctLightness : Data -> Float -> Float
correctLightness data val =
    let
        l0 =
            getDirectColor data 0 |> ToRgb.toNonEmptyList |> Nonempty.head

        l1 =
            getDirectColor data 1 |> ToRgb.toNonEmptyList |> Nonempty.head

        pol =
            l0 > l1

        actual =
            getDirectColor data val |> ToRgb.toNonEmptyList |> Nonempty.head

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
            getDirectColor data newT |> ToRgb.toNonEmptyList |> Nonempty.head
    in
    { diff = actual - ideal, t = newT, t0 = newT0, t1 = newT1 }


colorsNum : List Color.Color -> Int -> List Color.Color
colorsNum colors num =
    colorsFormat colors "hex" num


colorsFormat : List Color.Color -> String -> Int -> List Color.Color
colorsFormat colors format num =
    []


{-| TBD
-}
classes : List Color.Color -> Int -> List Color.Color
classes colors num =
    []


classesArray : List Color.Color -> List Float -> List Color.Color
classesArray colors arr =
    []
