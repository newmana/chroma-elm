module Chroma.Scale exposing (colors, getColor, domain, correctLightness, Data, createSharedData, defaultData, defaultColorList, defaultSharedData, CalculateColor(..))

{-| The attempt here is to provide something similar to <https://gka.github.io/chroma.js/> but also idiomatic Elm.


# Definition

@docs colors, getColor, domain, correctLightness, Data, createSharedData, defaultData, defaultColorList, defaultSharedData, CalculateColor

-}

import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Misc.ColorSpace as ColorSpace
import Chroma.Interpolator as Interpolator
import Chroma.Types as Types
import Color as Color
import List.Nonempty as Nonempty


type CalculateColor
    = ContinuousColor (Float -> Types.ExtColor)
    | DiscreteColor (Nonempty.Nonempty Types.ExtColor)


type alias Data =
    { c : CalculateColor
    , shared : SharedData
    }


{-| Configuration data used by most functions.
-}
type alias SharedData =
    { domainValues : ( Float, Float )
    , pos : Nonempty.Nonempty ( Float, Float )
    , paddingValues : ( Float, Float )
    , classes : Maybe (Nonempty.Nonempty Float)
    , useCorrectLightness : Bool
    , gammaValue : Float
    }


defaultData : Data
defaultData =
    { c = DiscreteColor defaultColorList
    , shared = defaultSharedData
    }


{-| Sensible default configuration defaults: RGB, domain 0-1, pos 0, 1,and white and black color range.
-}
defaultSharedData : SharedData
defaultSharedData =
    { domainValues = ( 0, 1 )
    , pos = Nonempty.fromElement ( 0, 1 )
    , paddingValues = ( 0, 0 )
    , classes = Nothing
    , useCorrectLightness = False
    , gammaValue = 1
    }


{-| The default color map - black to white.
-}
defaultColorList : Nonempty.Nonempty Types.ExtColor
defaultColorList =
    Nonempty.Nonempty (Types.RGBAColor W3CX11.white) [ Types.RGBAColor W3CX11.black ]


{-| Recalculate pos based on new colors.
-}
createPos : Int -> Nonempty.Nonempty ( Float, Float )
createPos numberOfColors =
    let
        colLength =
            numberOfColors - 1 |> toFloat

        newPos =
            Nonempty.map (\i -> ( toFloat i / colLength, toFloat (i + 1) / colLength )) (Nonempty.Nonempty 0 (List.range 1 numberOfColors))
    in
    newPos


{-| Setup new configuration with the given colors.
-}
createSharedData : Data -> Data
createSharedData data =
    let
        ensureTwoColors newColors =
            if Nonempty.isSingleton newColors then
                Nonempty.cons (Nonempty.head newColors) newColors

            else
                newColors
    in
    case data.c of
        ContinuousColor _ ->
            data

        DiscreteColor newColors ->
            let
                dataShared =
                    data.shared

                newShared =
                    { dataShared | pos = createPos (Nonempty.length newColors) }
            in
            { c = DiscreteColor (ensureTwoColors newColors)
            , shared = newShared
            }


{-| -}
getColor : CalculateColor -> SharedData -> Float -> Types.ExtColor
getColor colorsList data val =
    let
        ( min, max ) =
            data.domainValues
    in
    case data.classes of
        Nothing ->
            getDirectColor colorsList data ((val - min) / (max - min))

        Just c ->
            let
                getResult i ( done, index ) =
                    if val >= Nonempty.get i c then
                        ( False, index )

                    else
                        ( True, i - 1 )

                ( _, loc ) =
                    List.foldr getResult ( False, 0 ) (List.range 0 (Nonempty.length c))
            in
            getDirectColor colorsList data (toFloat loc / (Nonempty.length c - 2 |> toFloat))


getDirectColor : CalculateColor -> SharedData -> Float -> Types.ExtColor
getDirectColor colorsList data startT =
    let
        lightnessCorrectedT =
            if data.useCorrectLightness then
                correctLightness colorsList { data | useCorrectLightness = False } startT

            else
                startT

        gammaT =
            lightnessCorrectedT ^ data.gammaValue

        ( padLeft, padRight ) =
            data.paddingValues

        paddedT =
            padLeft + (gammaT * (1 - padLeft - padRight))

        boundedT =
            clamp 0 1 paddedT
    in
    case colorsList of
        ContinuousColor f ->
            fromContinuousColor f data boundedT

        DiscreteColor cl ->
            fromDiscreteColor cl data boundedT


fromContinuousColor : (Float -> Types.ExtColor) -> SharedData -> Float -> Types.ExtColor
fromContinuousColor colorF data t =
    let
        ( min, max ) =
            data.domainValues

        newT =
            (t - min) / (max - min)
    in
    colorF t


fromDiscreteColor : Nonempty.Nonempty Types.ExtColor -> SharedData -> Float -> Types.ExtColor
fromDiscreteColor colorsList data t =
    let
        posMax =
            Nonempty.length data.pos - 1

        ( _, interpolatedResult, _ ) =
            Nonempty.foldl
                (\( p0, p1 ) ( found, result, i ) ->
                    if not found then
                        if (t <= p0) || (t >= p0 && i == posMax) then
                            ( True, Nonempty.get i colorsList, i )

                        else if t > p0 && t < p1 then
                            let
                                newT =
                                    (t - p0) / (p1 - p0)

                                interT =
                                    Interpolator.interpolate (Nonempty.get i colorsList) (Nonempty.get (i + 1) colorsList) newT
                            in
                            ( True, interT, i )

                        else
                            ( found, result, i + 1 )

                    else
                        ( found, result, i + 1 )
                )
                ( False, Types.RGBAColor W3CX11.black, 0 )
                data.pos
    in
    interpolatedResult


createDomainPos : Nonempty.Nonempty ( Float, Float ) -> ( Float, Float ) -> Nonempty.Nonempty Float -> Nonempty.Nonempty ( Float, Float )
createDomainPos oldPos ( min, max ) newDomain =
    let
        newDenom =
            max - min

        maybeNonEmptyTail =
            case Nonempty.tail newDomain of
                [] ->
                    Nothing

                h :: r ->
                    Just (Nonempty.Nonempty h (r ++ [ Nonempty.get -1 newDomain ]))

        pairUp =
            case maybeNonEmptyTail of
                Nothing ->
                    oldPos

                Just nonEmptyTail ->
                    Nonempty.zip newDomain nonEmptyTail

        newPos =
            Nonempty.indexedMap (\_ ( d1, d2 ) -> ( (d1 - min) / newDenom, (d2 - min) / newDenom )) pairUp
    in
    newPos


domain : Nonempty.Nonempty Float -> Data -> Data
domain newDomain data =
    case data.c of
        DiscreteColor colorsList ->
            domainDiscrete newDomain colorsList data

        ContinuousColor _ ->
            domainContinuous newDomain data


{-| Set a new domain (like [0,100] rather than the default [0,1]) for discrete data.
-}
domainDiscrete : Nonempty.Nonempty Float -> Nonempty.Nonempty Types.ExtColor -> Data -> Data
domainDiscrete newDomain colorsList data =
    let
        ( newMin, newMax ) =
            ( Nonempty.head newDomain, Nonempty.get -1 newDomain )

        newPos =
            if Nonempty.length newDomain == Nonempty.length colorsList && newMin /= newMax then
                createDomainPos data.shared.pos ( newMin, newMax ) newDomain

            else
                createPos (Nonempty.length colorsList)

        shared =
            data.shared

        newShared =
            { shared | domainValues = ( newMin, newMax ), pos = newPos }
    in
    { data | shared = newShared }


{-| Set a new domain (like [0,100] rather than the default [0,1]) for continuous data.
-}
domainContinuous : Nonempty.Nonempty Float -> Data -> Data
domainContinuous newDomain data =
    let
        ( newMin, newMax ) =
            ( Nonempty.head newDomain, Nonempty.get -1 newDomain )

        newPos =
            createDomainPos data.shared.pos ( newMin, newMax ) newDomain

        shared =
            data.shared

        newShared =
            { shared | domainValues = ( newMin, newMax ), pos = newPos }
    in
    { data | shared = newShared }


type alias Convergence =
    { diff : Float
    , t : Float
    , t0 : Float
    , t1 : Float
    }


{-| Given a data change the lightness value (need to be LAB).
-}
correctLightness : CalculateColor -> SharedData -> Float -> Float
correctLightness colorsList data val =
    let
        l0 =
            getDirectColor colorsList data 0 |> ColorSpace.toNonEmptyList |> Nonempty.head

        l1 =
            getDirectColor colorsList data 1 |> ColorSpace.toNonEmptyList |> Nonempty.head

        pol =
            l0 > l1

        actual =
            getDirectColor colorsList data val |> ColorSpace.toNonEmptyList |> Nonempty.head

        ideal =
            l0 + ((l1 - l0) * val)

        diff =
            actual - ideal

        allResults =
            convergeResult colorsList data 20 pol ideal { diff = diff, t = val, t0 = 0, t1 = 1 }
    in
    allResults.t


convergeResult : CalculateColor -> SharedData -> Int -> Bool -> Float -> Convergence -> Convergence
convergeResult colorsList data maxIter pol ideal calcs =
    if (abs calcs.diff <= 0.01) || maxIter <= 0 then
        calcs

    else
        let
            result =
                calcResult colorsList data pol ideal calcs
        in
        convergeResult colorsList data (maxIter - 1) pol ideal result


calcResult : CalculateColor -> SharedData -> Bool -> Float -> Convergence -> Convergence
calcResult colorsList data pol ideal calcs =
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
            getDirectColor colorsList data newT |> ColorSpace.toNonEmptyList |> Nonempty.head
    in
    { diff = actual - ideal, t = newT, t0 = newT0, t1 = newT1 }


{-| Interpolate a range of colors from the list of colors in the data.
-}
colors : Int -> Data -> Nonempty.Nonempty Types.ExtColor
colors num data =
    case num of
        1 ->
            Nonempty.Nonempty (getColor data.c data.shared 0.5) []

        _ ->
            let
                ranged =
                    Nonempty.Nonempty 1 (List.range 2 num)
            in
            Nonempty.indexedMap (\i c -> getColor data.c data.shared (toFloat i / toFloat (num - 1))) ranged
