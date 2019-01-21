module Chroma exposing
    ( chroma
    , distance
    , distance255
    , distanceWithLab
    , scale
    , scaleDefault
    )

import Color as Color
import Colors.W3CX11 as W3CX11
import Converter.In.Hex2Rgb as Hex2Rgb
import Converter.Out.ToLab as ToLab
import Flip as Flip
import Result as Result
import Types as Types


chroma : String -> Result String Types.ExtColor
chroma str =
    case W3CX11.named str of
        Ok value ->
            Ok (Types.ExtColor value)

        Err err ->
            Hex2Rgb.hex2rgb str |> Result.map Types.ExtColor


scaleDefault : List (Float -> Types.ExtColor)
scaleDefault =
    scale [ Types.ExtColor W3CX11.white, Types.ExtColor W3CX11.black ]


scale : List Types.ExtColor -> List (Float -> Types.ExtColor)
scale colors =
    []


distanceWithLab : Types.ExtColor -> Types.ExtColor -> Float
distanceWithLab color1 color2 =
    let
        labColor a =
            ToLab.toLab a |> (\{ lightness, labA, labB } -> Types.LABColor lightness labA labB)
    in
    distance (labColor color1) (labColor color2)


distance255 : Types.ExtColor -> Types.ExtColor -> Float
distance255 color1 color2 =
    let
        fstColor255 =
            Types.asList color1 |> List.map (\x -> x * 255)

        sndColor255 =
            Types.asList color2 |> List.map (\x -> x * 255)
    in
    calcDistance fstColor255 sndColor255


distance : Types.ExtColor -> Types.ExtColor -> Float
distance color1 color2 =
    let
        aColor1 =
            Types.asList color1

        aColor2 =
            Types.asList color2
    in
    calcDistance aColor1 aColor2


calcDistance : List Float -> List Float -> Float
calcDistance list1 list2 =
    List.map2 (\c1 c2 -> (c1 - c2) ^ 2) list1 list2 |> List.sum |> sqrt



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
