module Chroma.Chroma exposing
    ( chroma, name, num, scale, domain, distance, distance255, mix, mixChroma, padding, paddingBoth, colors, colorsWith, average, averageChroma, limits, classes, classesWithArray
    , scaleDefault, scaleWith, domainWith
    )

{-| The attempt here is to provide something similar to <https://gka.github.io/chroma.js/> but also idiomatic Elm.


# Definition

@docs chroma, name, num, scale, domain, distance, distance255, mix, mixChroma, padding, paddingBoth, colors, colorsWith, average, averageChroma, limits, classes, classesWithArray


# Helpers

@docs scaleDefault, scaleWith, domainWith

-}

import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.In.Hex2Rgb as Hex2Rgb
import Chroma.Converter.Misc.ColorSpace as ColorSpace
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Converter.Out.ToRgba as ToRgba
import Chroma.Interpolator as Interpolator
import Chroma.Limits.Limits as Limits
import Chroma.Scale as Scale
import Chroma.Types as Types
import Color as Color
import List.Nonempty as Nonempty
import Result as Result


{-| Given a valid hex string (8, 6 or 3) produce an RGB Color.
-}
chroma : String -> Result String Types.ExtColor
chroma str =
    case W3CX11.named str of
        Ok value ->
            Ok (Types.RGBAColor value)

        Err _ ->
            Hex2Rgb.hex2rgb str |> Result.map Types.RGBAColor


{-| Given a color turn it into a W3CX11 name or fall back to RGB string.

Types.RGBAColor (Color.rgb255 255 0 255) |> Chroma.name

-}
name : Types.ExtColor -> Result String String
name ext =
    let
        { red, green, blue, alpha } =
            ToRgba.toRgba255 ext

        rgb255 =
            Color.rgb255 red green blue
    in
    case W3CX11.color rgb255 of
        Ok value ->
            Ok value

        Err _ ->
            Ok (ToHex.toHex ext)


num : Types.ExtColor -> Int
num ext =
    let
        { red, green, blue, alpha } =
            ToRgba.toRgba255 ext

        rgb255 =
            Color.rgb255 red green blue
    in
    W3CX11.colorToInt rgb255


{-| Return a new configuration and a function from a float to color based on default values - colors White to Black, domain 0 - 1.
-}
scaleDefault : ( Scale.Data, Float -> Types.ExtColor )
scaleDefault =
    ( Scale.defaultData, Scale.getColor Scale.defaultData )


{-| Return a new configuration and a function from a float to color based on default values and the given colors.
-}
scale : Nonempty.Nonempty Types.ExtColor -> ( Scale.Data, Float -> Types.ExtColor )
scale colorsList =
    scaleWith Scale.defaultData colorsList


{-| Return a new configuration and a function from a float to color based on the given configuration values and the given colors.
-}
scaleWith : Scale.Data -> Nonempty.Nonempty Types.ExtColor -> ( Scale.Data, Float -> Types.ExtColor )
scaleWith data colorsList =
    let
        newData =
            Scale.createData colorsList data
    in
    ( newData, Scale.getColor newData )


{-| Return a new configuration and a function from a float to color based on the given configuration values, the given
colors and the total number of colors (bins) to return.
-}
classes : Int -> Scale.Data -> ( Scale.Data, Float -> Types.ExtColor )
classes bins data =
    let
        newData =
            Scale.createData data.colorsList data

        newDataWithClasses =
            let
                d =
                    Nonempty.Nonempty (Tuple.first newData.domainValues) [ Tuple.second newData.domainValues ]
            in
            if bins == 0 then
                { newData | classes = Just d }

            else
                { newData | classes = Just (limits d Limits.Equal bins) }
    in
    ( newDataWithClasses, Scale.getColor newDataWithClasses )


{-| Return a new configuration and a function from a float to color based on the given configuration values, the given
colors and a predefined set of breaks/classes.
-}
classesWithArray : Nonempty.Nonempty Float -> Scale.Data -> ( Scale.Data, Float -> Types.ExtColor )
classesWithArray newClasses data =
    let
        updateData =
            { data | classes = Just newClasses } |> Scale.domain newClasses

        newData =
            Scale.createData data.colorsList updateData
    in
    ( newData, Scale.getColor newData )


{-| Return a new configuration and a function from a float to color based on a new domain, colors (must be the same
length as the domain) and default configuration.
-}
domain : Nonempty.Nonempty Float -> Nonempty.Nonempty Types.ExtColor -> ( Scale.Data, Float -> Types.ExtColor )
domain newDomain colorsList =
    let
        newData =
            Scale.defaultData |> Scale.createData colorsList |> Scale.domain newDomain
    in
    ( newData, Scale.getColor newData )


{-| Return a new configuration and a function from a float to color based on a new domain, an existing configuration,
and colors (must be the same length as the domain).
-}
domainWith : Nonempty.Nonempty Float -> Scale.Data -> Nonempty.Nonempty Types.ExtColor -> ( Scale.Data, Float -> Types.ExtColor )
domainWith newDomain data colorsList =
    let
        newData =
            data |> Scale.createData colorsList |> Scale.domain newDomain
    in
    ( newData, Scale.getColor newData )


{-| Remove a fraction of the color gradient (0 -> 1). Applies both sides the same.
-}
padding : Float -> ( Scale.Data, Float -> Types.ExtColor ) -> ( Scale.Data, Float -> Types.ExtColor )
padding both dataAndF =
    paddingBoth ( both, both ) dataAndF


{-| Remove a fraction of the color gradient (0 -> 1).
-}
paddingBoth : ( Float, Float ) -> ( Scale.Data, Float -> Types.ExtColor ) -> ( Scale.Data, Float -> Types.ExtColor )
paddingBoth ( newLeft, newRight ) ( data, _ ) =
    let
        newData =
            { data | paddingValues = ( newLeft, newRight ) }
    in
    scaleWith newData newData.colorsList


{-| Return the data with the given colors and a new list of colors.
-}
colors : Int -> Nonempty.Nonempty Types.ExtColor -> ( Scale.Data, Nonempty.Nonempty Types.ExtColor )
colors i colorsList =
    let
        newData =
            Scale.defaultData |> Scale.createData colorsList
    in
    colorsWith i newData


{-| Return the data with the given colors and a new list of colors.
-}
colorsWith : Int -> Scale.Data -> ( Scale.Data, Nonempty.Nonempty Types.ExtColor )
colorsWith i data =
    ( data, Scale.colors i data )


{-| Calculate the distance in RGB 255 color space.
-}
distance255 : Types.ExtColor -> Types.ExtColor -> Float
distance255 color1 color2 =
    let
        fstColor255 =
            ColorSpace.colorConvert Types.RGBA color1 |> ColorSpace.toNonEmptyList |> Nonempty.map (\x -> x * 255)

        sndColor255 =
            ColorSpace.colorConvert Types.RGBA color2 |> ColorSpace.toNonEmptyList |> Nonempty.map (\x -> x * 255)
    in
    calcDistance fstColor255 sndColor255


{-| Calculate the distance for a given color space.
-}
distance : Types.Mode -> Types.ExtColor -> Types.ExtColor -> Float
distance mode color1 color2 =
    let
        aColor1 =
            ColorSpace.colorConvert mode color1 |> ColorSpace.toNonEmptyList

        aColor2 =
            ColorSpace.colorConvert mode color2 |> ColorSpace.toNonEmptyList
    in
    calcDistance aColor1 aColor2


calcDistance : Nonempty.Nonempty Float -> Nonempty.Nonempty Float -> Float
calcDistance list1 list2 =
    Nonempty.map2 (\c1 c2 -> (c1 - c2) ^ 2) list1 list2 |> Nonempty.foldl (+) 0 |> sqrt


{-| Mix two colors, first converting them to the same color space mode and then with a ratio.
-}
mix : Types.Mode -> Float -> Types.ExtColor -> Types.ExtColor -> Types.ExtColor
mix mode f color1 color2 =
    let
        convert =
            ColorSpace.colorConvert mode
    in
    Interpolator.interpolate (convert color1) (convert color2) f


{-| Mix two colors defined as a string, first converting them to the same color space mode and then with a ratio.
-}
mixChroma : Types.Mode -> Float -> String -> String -> Result String Types.ExtColor
mixChroma mode f color1 color2 =
    Result.map2 (mix mode f) (chroma color1) (chroma color2)


{-| Find the average of a non-empty list of colors, first converting them to the same color space mode.

Only supports RGBA, CYMK and LAB.

-}
average : Types.Mode -> Nonempty.Nonempty Types.ExtColor -> Result String Types.ExtColor
average mode extList =
    let
        calcAverage =
            case mode of
                Types.RGBA ->
                    Ok result

                Types.CMYK ->
                    Ok result

                Types.LAB ->
                    Ok result

                _ ->
                    Err "Mode not supported"

        result =
            Nonempty.map (ColorSpace.colorConvert mode) extList |> ColorSpace.rollingAverage
    in
    calcAverage


{-| Find the average of a non-empty list of colors defined as strongs, first converting them to the same color space mode.

Only supports RGBA, CYMK and LAB.

-}
averageChroma : Types.Mode -> Nonempty.Nonempty String -> Result String Types.ExtColor
averageChroma mode strList =
    Nonempty.map chroma strList |> ColorSpace.combine |> Result.andThen (average mode)


{-| Create breaks/classes based on the data given.

Supports: CkMean (a variant of kMeans), Equal, Logarithmic, and Quantile.

-}
limits : Nonempty.Nonempty Float -> Limits.LimitMode -> Int -> Nonempty.Nonempty Float
limits data mode bins =
    Limits.limits data mode bins
