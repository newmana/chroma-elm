module Chroma
    exposing
        ( chroma
        , scaleDefault
        , scale
        )

import Color
import Result
import Colors.W3CX11 as W3CX11
import Converter.In.Hex2Rgb as Hex2Rgb


chroma : String -> Result String Color.Color
chroma str =
    case W3CX11.named str of
        Ok value ->
            Ok value

        Err err ->
            Hex2Rgb.hex2rgb str


scaleDefault : List (Float -> Color.Color)
scaleDefault =
    scale [ W3CX11.white, W3CX11.black ]


scale : List Color.Color -> List (Float -> Color.Color)
scale colors =
    []



--mix color1 color2 ratio mode =
--    Debug.crash "unimplemented"
--average colors mode =
--    Debug.crash "unimplemented"
--blend color1 color2 mode =
--    Debug.crash "unimplemented"
--random =
--    Debug.crash "unimplemented"
--contrast color1 color2 =
--    Debug.crash "unimplemented"
--brewer brewerName =
--    Debug.crash "unimplemented"
--limits data mode n =
--    Debug.crash "unimplemented"
