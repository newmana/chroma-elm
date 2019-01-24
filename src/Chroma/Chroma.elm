module Chroma.Chroma exposing
    ( chroma
    , distance
    , distance255
    , distanceWithLab
    , scale
    , scaleDefault
    )

import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.In.Hex2Rgb as Hex2Rgb
import Chroma.Converter.Out.ToLab as ToLab
import Chroma.Scale as Scale
import Chroma.Types as Types
import Color as Color
import Debug
import Flip as Flip
import List.Nonempty as Nonempty
import Result as Result


chroma : String -> Result String Types.ExtColor
chroma str =
    case W3CX11.named str of
        Ok value ->
            Ok (Types.ExtColor value)

        Err err ->
            Hex2Rgb.hex2rgb str |> Result.map Types.ExtColor


scaleDefault : List (Float -> Types.ExtColor)
scaleDefault =
    scale Scale.defaultData [ Types.ExtColor W3CX11.white, Types.ExtColor W3CX11.black ]


scale : Scale.Data -> List Types.ExtColor -> List (Float -> Types.ExtColor)
scale colors =
    Debug.todo ""


distanceWithLab : Types.ExtColor -> Types.ExtColor -> Float
distanceWithLab color1 color2 =
    let
        labColor a =
            ToLab.toLab a |> Types.LABColor
    in
    distance (labColor color1) (labColor color2)


distance255 : Types.ExtColor -> Types.ExtColor -> Float
distance255 color1 color2 =
    let
        fstColor255 =
            Types.asNonEmptyList color1 |> Nonempty.map (\x -> x * 255)

        sndColor255 =
            Types.asNonEmptyList color2 |> Nonempty.map (\x -> x * 255)
    in
    calcDistance fstColor255 sndColor255


distance : Types.ExtColor -> Types.ExtColor -> Float
distance color1 color2 =
    let
        aColor1 =
            Types.asNonEmptyList color1

        aColor2 =
            Types.asNonEmptyList color2
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
