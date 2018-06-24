module Chroma
    exposing
        ( chroma
        )

import Regex
import List
import Color
import Char
import Result
import Colors.W3CX11 as W3CX11
import Converter.In.Hex2Rgb as Hex2Rgb


chroma str =
    case W3CX11.named str of
        Ok value ->
            Ok value

        Err err ->
            Hex2Rgb.hex2rgb str
