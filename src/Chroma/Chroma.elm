module Chroma.Chroma exposing
    ( chroma, name, mix, mixChroma, average, averageChroma, blend, blendChroma, contrast, contrastChroma, distance, distance255, limits
    , scale, scaleF, colors, colorsF, domain, domainF, classes, padding, paddingBoth
    , scaleDefault, scaleWith, colorsWith, domainWith, classesWithArray, paddingWith, paddingBothWith
    )

{-| The attempt here is to provide something similar to [Chroma.js](https://gka.github.io/chroma.js/) but also
has more features and is idiomatic Elm.


# Color

@docs chroma, name, mix, mixChroma, average, averageChroma, blend, blendChroma, contrast, contrastChroma, distance, distance255, limits


# Color Scales

@docs scale, scaleF, colors, colorsF, domain, domainF, classes, padding, paddingBoth


# Color Scales Helpers

@docs scaleDefault, scaleWith, colorsWith, domainWith, classesWithArray, paddingWith, paddingBothWith

-}

import Chroma.Blend as Blend
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.In.Hex2Rgb as Hex2Rgb
import Chroma.Converter.Misc.ColorSpace as ColorSpace
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Converter.Out.ToRgba as ToRgba
import Chroma.Interpolator as Interpolator
import Chroma.Limits.Limits as Limits
import Chroma.Ops.Luminance as Luminance
import Chroma.Ops.Numeric as Numeric
import Chroma.Scale as Scale
import Chroma.Types as Types
import Color
import List.Nonempty as Nonempty
import Result


{-| Given a valid hex string (8, 6 or 3) or [`W3CX11 Color`][w3cx11] name and produce an RGB Color.

    Chroma.chroma "magenta"
    --> Ok (RGBAColor (RgbaSpace 1 0 1 1)) : Result String Types.ExtColor

    Chroma.chroma "#c0c0c0"
    --> Ok (RGBAColor (RgbaSpace 0.7529411764705882 0.7529411764705882 0.7529411764705882 1)) : Result String Types.ExtColor

[w3cx11]: Chroma-Colors-W3CX11

-}
chroma : String -> Result String Types.ExtColor
chroma colorName =
    case W3CX11.named colorName of
        Ok value ->
            Ok (Types.RGBAColor value)

        Err _ ->
            Hex2Rgb.hex2rgb colorName |> Result.map Types.RGBAColor


{-| Given a color turn it into a [`W3CX11 Color`][w3cx11] name or fall back to an RGB string.

    Types.RGBAColor (Color.rgb255 255 0 255) |> Chroma.name
    --> Ok "magenta" : Result String String

[w3cx11]: Chroma-Colors-W3CX11

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


{-| Mix two colors, first converting them to the same color space and then interpolate them with the given ratio.

    Chroma.mix Types.RGBA 0.25 (Types.RGBAColor W3CX11.red) (Types.RGBAColor W3CX11.blue)
    --> RGBAColor (RgbaSpace 0.75 0 0.25 1) : Types.ExtColor

-}
mix : Types.Mode -> Float -> Types.ExtColor -> Types.ExtColor -> Types.ExtColor
mix mode f color1 color2 =
    let
        convert =
            ColorSpace.colorConvert mode
    in
    Interpolator.interpolate (convert color1) (convert color2) f


{-| Mix two colors defined as a string, first converting them to the same color space mode and then interpolate
with the given ratio.

    Chroma.mixChroma Types.RGBA 0.25 "red" "blue"
    --> Ok (RGBAColor (RgbaSpace 0.75 0 0.25 1)) : Result String Types.ExtColor

-}
mixChroma : Types.Mode -> Float -> String -> String -> Result String Types.ExtColor
mixChroma mode f color1 color2 =
    Result.map2 (mix mode f) (chroma color1) (chroma color2)


{-| Find the average of a non-empty list of colors, first converting them to the same color space.

Only supports RGBA, CYMK and LAB.

    Chroma.average Types.RGBA (Nonempty.Nonempty (Types.RGBAColor W3CX11.red) [(Types.RGBAColor W3CX11.blue)])
    --> Ok (RGBAColor (RgbaSpace 0.5 0 0.5 1)) : Result String Types.ExtColor

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


{-| Find the average of a non-empty list of colors defined as strings, first converting them to the same color space.

Only supports RGBA, CYMK and LAB.

    Chroma.averageChroma Types.RGBA (Nonempty.Nonempty "red" ["blue"])
    --> Ok (RGBAColor (RgbaSpace 0.5 0 0.5 1)) : Result String Types.ExtColor

-}
averageChroma : Types.Mode -> Nonempty.Nonempty String -> Result String Types.ExtColor
averageChroma mode strList =
    Nonempty.map chroma strList |> ColorSpace.combine |> Result.andThen (average mode)


{-| Combine two colors using the given blend modes.

    Chroma.blend Blend.Burn (Types.RGBAColor W3CX11.red) (Types.RGBAColor W3CX11.blue)
    --> RGBAColor (RgbaSpace 0 0 1 1) : Types.ExtColor

-}
blend : Blend.BlendMode -> Types.ExtColor -> Types.ExtColor -> Types.ExtColor
blend mode color1 color2 =
    Blend.blend mode color1 color2


{-| Combine two colors, defined as strings, using the given blend modes.

    Chroma.blendChroma Blend.Darken "cyan" "magenta"
    --> Ok (RGBAColor (RgbaSpace 0 0 1 1)) : Result String Types.ExtColor

-}
blendChroma : Blend.BlendMode -> String -> String -> Result String Types.ExtColor
blendChroma mode strColor1 strColor2 =
    Result.map2 (Blend.blend mode) (chroma strColor1) (chroma strColor2)


{-| [`WCGA contrast`](https://www.w3.org/TR/WCAG20-TECHS/) ratio between two colors.

    Chroma.contrast (Types.RGBAColor W3CX11.pink) (Types.RGBAColor W3CX11.hotpink)
    --> 1.7214765344592284 : Float

-}
contrast : Types.ExtColor -> Types.ExtColor -> Float
contrast color1 color2 =
    Luminance.contrast color1 color2


{-| [`WCGA contrast`](https://www.w3.org/TR/WCAG20-TECHS/) ratio between two colors.

    Chroma.contrastChroma "pink" "hotpink"
    --> Ok 1.7214765344592284 : Result String Float

-}
contrastChroma : String -> String -> Result String Float
contrastChroma strColor1 strColor2 =
    Result.map2 Luminance.contrast (chroma strColor1) (chroma strColor2)


{-| Calculate the distance in RGB 255 color space.

    Chroma.distance255 (Types.RGBAColor W3CX11.red) (Types.RGBAColor W3CX11.blue)
    --> 360.62445840513925 : Float

-}
distance255 : Types.ExtColor -> Types.ExtColor -> Float
distance255 color1 color2 =
    let
        fstColor255 =
            ColorSpace.colorConvert Types.RGBA color1 |> ColorSpace.toNonEmptyList |> Nonempty.map (\x -> x * 255)

        sndColor255 =
            ColorSpace.colorConvert Types.RGBA color2 |> ColorSpace.toNonEmptyList |> Nonempty.map (\x -> x * 255)
    in
    Numeric.calcDistance fstColor255 sndColor255


{-| Calculate the distance for a given color space.

    Chroma.distance Types.RGBA (Types.RGBAColor W3CX11.red) (Types.RGBAColor W3CX11.blue)
    --> 1.4142135623730951 : Float

-}
distance : Types.Mode -> Types.ExtColor -> Types.ExtColor -> Float
distance mode color1 color2 =
    let
        aColor1 =
            ColorSpace.colorConvert mode color1 |> ColorSpace.toNonEmptyList

        aColor2 =
            ColorSpace.colorConvert mode color2 |> ColorSpace.toNonEmptyList
    in
    Numeric.calcDistance aColor1 aColor2


{-| Create breaks/classes based on the data given.

Supports: CkMeans (a variant of kmeans), Equal, Head/Tail, Jenks, Logarithmic, and Quantile.

    Chroma.limits Limits.Equal 5 (Nonempty.Nonempty 0 [ 10 ])
    --> Nonempty 0 [2,4,6,8,10] : Nonempty.Nonempty Float

    Chroma.limits Limits.CkMeans 3 (Nonempty.Nonempty 1 [ 2, 1, 4, 3, 5, 2, 5, 4 ])
    --> Nonempty 1 [2,4] : Nonempty.Nonempty Float

-}
limits : Limits.LimitMode -> Int -> Nonempty.Nonempty Float -> Nonempty.Nonempty Float
limits mode bins data =
    Limits.limits mode bins data


{-| Return a configuration and a function from a float to a color based on the default values - colors White to Black,
domain 0 - 1.
-}
scaleDefault : ( Scale.Data, Float -> Types.ExtColor )
scaleDefault =
    scale Scale.defaultColorList


{-| Return a configuration and a function from a float to a color based on default values and a list of colors.
-}
scale : Nonempty.Nonempty Types.ExtColor -> ( Scale.Data, Float -> Types.ExtColor )
scale colorsList =
    scaleWith (Scale.createDiscreteColorData colorsList Scale.defaultSharedData)


{-| Return a configuration and a function from a float to a color based on default values and a function given a
value from 0 -> 1 produces a new color.
-}
scaleF : (Float -> Types.ExtColor) -> ( Scale.Data, Float -> Types.ExtColor )
scaleF colorFunction =
    scaleWith (Scale.createContinuousColorData colorFunction Scale.defaultSharedData)


{-| Return a new configuration and a function from a float to a color based on the given configuration values and
the given colors.
-}
scaleWith : Scale.Data -> ( Scale.Data, Float -> Types.ExtColor )
scaleWith data =
    let
        newData =
            Scale.initSharedData data
    in
    ( newData, Scale.getColor newData )


{-| Return a new configuration and a function from a float to a color using the default configuration, the given
colors and the total number of colors (bins) to return.
-}
classes : Int -> Scale.Data -> ( Scale.Data, Float -> Types.ExtColor )
classes bins data =
    let
        newData =
            Scale.initSharedData data

        newSharedData =
            newData.shared

        newSharedDataWithClasses =
            let
                newDomainValues =
                    newSharedData.domainValues

                d =
                    Nonempty.Nonempty (Tuple.first newDomainValues) [ Tuple.second newDomainValues ]
            in
            if bins == 0 then
                { newSharedData | classes = Just d }

            else
                { newSharedData | classes = Just (limits Limits.Equal bins d) }

        updatedData =
            { data | shared = newSharedDataWithClasses }
    in
    ( updatedData, Scale.getColor updatedData )


{-| Return a new configuration and a function from a float to a color based on the given configuration values, the given
colors and a predefined set of breaks/classes.
-}
classesWithArray : Nonempty.Nonempty Float -> Scale.Data -> ( Scale.Data, Float -> Types.ExtColor )
classesWithArray newClasses data =
    let
        oldShared =
            data.shared

        matchNewClassesInShared =
            { oldShared | classes = Just newClasses }

        setDomainInData =
            { data | shared = matchNewClassesInShared } |> Scale.domain newClasses

        newData =
            Scale.initSharedData setDomainInData
    in
    ( newData, Scale.getColor newData )


{-| Return a new configuration and a function from a float to a color based on a new domain and list of colors.
The list of colors must be the same length as the domain or only the first and last values will be used.
-}
domain : Nonempty.Nonempty Float -> Nonempty.Nonempty Types.ExtColor -> ( Scale.Data, Float -> Types.ExtColor )
domain newDomain colorsList =
    let
        newData =
            Scale.createDiscreteColorData colorsList Scale.defaultSharedData |> Scale.domain newDomain
    in
    ( newData, Scale.getColor newData )


{-| Return a new configuration and a function from a float to a color based on a new domain and a function given a
value from 0 -> 1 produces a new color.
-}
domainF : Nonempty.Nonempty Float -> (Float -> Types.ExtColor) -> ( Scale.Data, Float -> Types.ExtColor )
domainF newDomain colorFunction =
    let
        newData =
            Scale.createContinuousColorData colorFunction Scale.defaultSharedData |> Scale.domain newDomain
    in
    ( newData, Scale.getColor newData )


{-| Return a new configuration and a function from a float to a color based on an existing configuration and a new
domain. If using a list of colors, they must be the same length as the domain or only the first and last values will
be used.
-}
domainWith : Scale.Data -> Nonempty.Nonempty Float -> ( Scale.Data, Float -> Types.ExtColor )
domainWith data newDomain =
    let
        newData =
            Scale.initSharedData data |> Scale.domain newDomain
    in
    ( newData, Scale.getColor newData )


{-| Remove a fraction of the color gradient (0 -> 1). Applies to both sides equally.
-}
padding : Float -> Nonempty.Nonempty Types.ExtColor -> ( Scale.Data, Float -> Types.ExtColor )
padding both colorsList =
    paddingBoth ( both, both ) colorsList


{-| Remove a fraction of the color gradient (0 -> 1).
-}
paddingBoth : ( Float, Float ) -> Nonempty.Nonempty Types.ExtColor -> ( Scale.Data, Float -> Types.ExtColor )
paddingBoth ( newLeft, newRight ) colorsList =
    let
        newData =
            Scale.createDiscreteColorData colorsList Scale.defaultSharedData
    in
    paddingBothWith newData ( newLeft, newRight )


{-| Remove a fraction of the color gradient (0 -> 1). Applies both sides equally.
-}
paddingWith : Scale.Data -> Float -> ( Scale.Data, Float -> Types.ExtColor )
paddingWith data both =
    paddingBothWith data ( both, both )


{-| Remove a fraction of the color gradient (0 -> 1).
-}
paddingBothWith : Scale.Data -> ( Float, Float ) -> ( Scale.Data, Float -> Types.ExtColor )
paddingBothWith data ( newLeft, newRight ) =
    let
        oldShared =
            data.shared

        newShared =
            { oldShared | paddingValues = ( newLeft, newRight ) }

        newData =
            { data | shared = newShared }
    in
    scaleWith newData


{-| Return a configuration and a list of colors based on the number of equal distance buckets to create and a
list of colors.
-}
colors : Int -> Nonempty.Nonempty Types.ExtColor -> ( Scale.Data, Nonempty.Nonempty Types.ExtColor )
colors i colorsList =
    let
        newData =
            Scale.createDiscreteColorData colorsList Scale.defaultSharedData
    in
    colorsWith newData i


{-| Return a configuration and a list of colors based on the number of equal distance buckets to create
and a function given a value from 0 -> 1 produces a new color.
-}
colorsF : Int -> (Float -> Types.ExtColor) -> ( Scale.Data, Nonempty.Nonempty Types.ExtColor )
colorsF i colorFunction =
    let
        newData =
            Scale.createContinuousColorData colorFunction Scale.defaultSharedData
    in
    colorsWith newData i


{-| Return the data with the given colors and a new list of colors.
-}
colorsWith : Scale.Data -> Int -> ( Scale.Data, Nonempty.Nonempty Types.ExtColor )
colorsWith data i =
    ( data, Scale.colors i data )
