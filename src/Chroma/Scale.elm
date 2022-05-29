module Chroma.Scale exposing
    ( colors, getColor, domain, correctLightness, Data, initSharedData, createDiscreteColorData, createContinuousColorData, defaultData, defaultColorList, defaultSharedData, CalculateColor(..)
    , SharedData
    )

{-| Used by [`Chroma`][chroma]

[chroma]: Chroma-Chroma


# Definition

@docs colors, getColor, domain, correctLightness, Data, initSharedData, createDiscreteColorData, createContinuousColorData, defaultData, defaultColorList, defaultSharedData, CalculateColor

-}

import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Misc.ColorSpace as ColorSpace
import Chroma.Interpolator as Interpolator
import Chroma.Types as Types
import List.Nonempty as Nonempty


{-| The two types of colors we accept - continuous (a function to color) or discrete (a list of colors).
-}
type CalculateColor
    = ContinuousColor (Float -> Types.ExtColor)
    | DiscreteColor (Nonempty.Nonempty Types.ExtColor)


{-| Configuration data used by most functions with color specific details.
-}
type alias Data =
    { c : CalculateColor
    , shared : SharedData
    }


{-| Shared configuration used by most functions.
-}
type alias SharedData =
    { domainValues : ( Float, Float )
    , pos : Nonempty.Nonempty ( Float, Float )
    , paddingValues : ( Float, Float )
    , classes : Maybe (Nonempty.Nonempty Float)
    , useCorrectLightness : Bool
    , gammaValue : Float
    }


{-| -}
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


{-| Create and init a continuous data configuration.
-}
createContinuousColorData : (Float -> Types.ExtColor) -> SharedData -> Data
createContinuousColorData colorFunction sharedData =
    { c = ContinuousColor colorFunction
    , shared = sharedData
    }
        |> initSharedData


{-| Create and init a discrete data configuration.
-}
createDiscreteColorData : Nonempty.Nonempty Types.ExtColor -> SharedData -> Data
createDiscreteColorData colorsList sharedData =
    { c = DiscreteColor colorsList
    , shared = sharedData
    }
        |> initSharedData


{-| Setup new configuration with the given colors.
-}
initSharedData : Data -> Data
initSharedData data =
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
getColor : Data -> Float -> Types.ExtColor
getColor data val =
    let
        ( min, max ) =
            data.shared.domainValues
    in
    case data.shared.classes of
        Nothing ->
            getDirectColor data ((val - min) / (max - min))

        Just c ->
            let
                getResult i ( _, index ) =
                    if val >= Nonempty.get i c then
                        ( False, index )

                    else
                        ( True, i - 1 )

                ( _, loc ) =
                    List.foldr getResult ( False, 0 ) (List.range 0 (Nonempty.length c))
            in
            getDirectColor data (toFloat loc / (Nonempty.length c - 2 |> toFloat))


getDirectColor : Data -> Float -> Types.ExtColor
getDirectColor data startT =
    let
        lightnessCorrectedT =
            if data.shared.useCorrectLightness then
                let
                    shareData =
                        data.shared

                    newShared =
                        { shareData | useCorrectLightness = False }

                    newData =
                        { data | shared = newShared }
                in
                correctLightness newData startT

            else
                startT

        gammaT =
            lightnessCorrectedT ^ data.shared.gammaValue

        ( padLeft, padRight ) =
            data.shared.paddingValues

        paddedT =
            padLeft + (gammaT * (1 - padLeft - padRight))

        boundedT =
            clamp 0 1 paddedT
    in
    case data.c of
        ContinuousColor f ->
            fromContinuousColor f data.shared boundedT

        DiscreteColor cl ->
            fromDiscreteColor cl data.shared boundedT


fromContinuousColor : (Float -> Types.ExtColor) -> SharedData -> Float -> Types.ExtColor
fromContinuousColor colorF _ t =
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


{-| Set a new domain (like [0,100] rather than the default [0,1]) for all kinds of data.
-}
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
correctLightness : Data -> Float -> Float
correctLightness data val =
    let
        l0 =
            getDirectColor data 0 |> ColorSpace.toNonEmptyList |> Nonempty.head

        l1 =
            getDirectColor data 1 |> ColorSpace.toNonEmptyList |> Nonempty.head

        pol =
            l0 > l1

        actual =
            getDirectColor data val |> ColorSpace.toNonEmptyList |> Nonempty.head

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
            getDirectColor data newT |> ColorSpace.toNonEmptyList |> Nonempty.head
    in
    { diff = actual - ideal, t = newT, t0 = newT0, t1 = newT1 }


{-| Interpolate a range of colors from the list of colors in the data.
-}
colors : Int -> Data -> Nonempty.Nonempty Types.ExtColor
colors num data =
    case num of
        1 ->
            Nonempty.Nonempty (getColor data 0.5) []

        _ ->
            let
                ranged =
                    Nonempty.Nonempty 1 (List.range 2 num)
            in
            Nonempty.indexedMap (\i _ -> getColor data (toFloat i / toFloat (num - 1))) ranged
