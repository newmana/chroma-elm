module Chroma
    exposing
        ( chroma
        , scaleDefault
        , scale
        , distanceWithLab
        , distance
        )

import Result as Result
import Types as Types
import Colors.W3CX11 as W3CX11
import Converter.In.Hex2Rgb as Hex2Rgb
import List.Extra as ListExtra


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
    distance color1 color2 Types.LAB


distance : Types.ExtColor -> Types.ExtColor -> Types.Mode -> Float
distance color1 color2 mode =
    let
        aColor1 =
            Types.asList color1

        aColor2 =
            Types.asList color2
    in
        ListExtra.lift2 (\x y -> (x - y) ^ 2) aColor1 aColor2 |> List.sum |> sqrt



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
