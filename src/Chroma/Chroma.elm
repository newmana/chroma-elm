module Chroma.Chroma exposing
    ( chroma, scale, domain, distance, distance255, distanceWithLab, padding, paddingBoth, colors, colorsWith
    , scaleDefault, scaleWith, domainWith
    )

{-| The attempt here is to provide something similar to <https://gka.github.io/chroma.js/> but also idiomatic Elm.


# Definition

@docs chroma, scale, domain, distance, distance255, distanceWithLab, padding, paddingBoth, colors, colorsWith


# Helpers

@docs scaleDefault, scaleWith, domainWith

-}

import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.In.Hex2Rgb as Hex2Rgb
import Chroma.Converter.Out.ToLab as ToLab
import Chroma.Converter.Out.ToRgb as ToRgb
import Chroma.Scale as Scale
import Chroma.Types as Types
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
colors num colorsList =
    let
        newData =
            Scale.defaultData |> Scale.createData colorsList
    in
    colorsWith num newData


{-| Return the data with the given colors and a new list of colors.
-}
colorsWith : Int -> Scale.Data -> ( Scale.Data, Nonempty.Nonempty Types.ExtColor )
colorsWith num data =
    ( data, Scale.colors num data )


{-| Calculate the distance in LAB color space.
-}
distanceWithLab : Types.ExtColor -> Types.ExtColor -> Float
distanceWithLab color1 color2 =
    let
        labColor a =
            ToLab.toLab a |> Types.LABColor
    in
    distance (labColor color1) (labColor color2)


{-| Calculate the distance in RGB 255 color space.
-}
distance255 : Types.ExtColor -> Types.ExtColor -> Float
distance255 color1 color2 =
    let
        fstColor255 =
            ToRgb.toNonEmptyList color1 |> Nonempty.map (\x -> x * 255)

        sndColor255 =
            ToRgb.toNonEmptyList color2 |> Nonempty.map (\x -> x * 255)
    in
    calcDistance fstColor255 sndColor255


{-| Calculate the distance in RGB color space.
-}
distance : Types.ExtColor -> Types.ExtColor -> Float
distance color1 color2 =
    let
        aColor1 =
            ToRgb.toNonEmptyList color1

        aColor2 =
            ToRgb.toNonEmptyList color2
    in
    calcDistance aColor1 aColor2


calcDistance : Nonempty.Nonempty Float -> Nonempty.Nonempty Float -> Float
calcDistance list1 list2 =
    Nonempty.map2 (\c1 c2 -> (c1 - c2) ^ 2) list1 list2 |> Nonempty.foldl (+) 0 |> sqrt



--mix color1 color2 ratio mode =
--    Debug.crash "unimplemented"
--average colors mode =
--    Debug.crash "unimplemented"
--blend color1 color2 mode =
--    Debug.crash "unimplemented"
--random =
--    Debug.crash "unimplemented"
--brewer brewerName =
--    Debug.crash "unimplemented"
--limits data mode n =
--    Debug.crash "unimplemented"
