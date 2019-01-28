module Chroma.Chroma exposing
    ( chroma, scale, domain, distance, distance255, distanceWithLab
    , scaleDefault, scaleWith, domainWith
    )

{-| The attempt here is to provide something similar to <https://gka.github.io/chroma.js/> but also idiomatic Elm.


# Definition

@docs chroma, scale, domain, distance, distance255, distanceWithLab, domain


# Helpers

@docs scaleDefault, scaleWith, domainWith

-}

import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.In.Hex2Rgb as Hex2Rgb
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Converter.Out.ToLab as ToLab
import Chroma.Converter.Out.ToRgb as ToRgb
import Chroma.Scale as Scale
import Chroma.Types as Types
import Color as Color
import Flip as Flip
import List.Nonempty as Nonempty
import Result as Result


{-| Given a valid hex string (6 or 3) produce an RGB Color.
-}
chroma : String -> Result String Types.ExtColor
chroma str =
    case W3CX11.named str of
        Ok value ->
            Ok (Types.RGBColor value)

        Err err ->
            Hex2Rgb.hex2rgb str |> Result.map Types.RGBColor


{-| Return a new configuration and a function from float to color based on default values - colors White to Black, domain 0 - 1.
-}
scaleDefault : ( Scale.Data, Float -> Types.ExtColor )
scaleDefault =
    scaleWith Scale.defaultData Scale.defaultData.colors


{-| Return a new configuration and a function from float to color based on default values and the given colors.
-}
scale : Nonempty.Nonempty Types.ExtColor -> ( Scale.Data, Float -> Types.ExtColor )
scale colors =
    scaleWith Scale.defaultData colors


{-| Return a new configuration and a function from float to color based on the given configuration values and the given colors.
-}
scaleWith : Scale.Data -> Nonempty.Nonempty Types.ExtColor -> ( Scale.Data, Float -> Types.ExtColor )
scaleWith data colors =
    let
        newData =
            { data | colors = colors }
    in
    ( newData, Scale.getColor newData )


{-| Return a new configuration and a function from float to color based on default values, the given colors and domain.
-}
domain : Nonempty.Nonempty Float -> Nonempty.Nonempty Types.ExtColor -> ( Scale.Data, Float -> Types.ExtColor )
domain newDomain colors =
    let
        ( newData, f ) =
            scale colors

        domainData =
            Scale.domain newDomain newData
    in
    scaleWith domainData colors


{-| Return a new configuration and a function from float to color based on the given configuration values, the given colors and domain.
-}
domainWith : Nonempty.Nonempty Float -> Scale.Data -> Nonempty.Nonempty Types.ExtColor -> ( Scale.Data, Float -> Types.ExtColor )
domainWith newDomain data colors =
    let
        domainData =
            Scale.domain newDomain data
    in
    scaleWith domainData colors


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
