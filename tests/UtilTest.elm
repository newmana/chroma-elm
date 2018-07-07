module UtilTest exposing (..)

import Fuzz as Fuzz
import Color as Color


validRgb : Fuzz.Fuzzer Color.Color
validRgb =
    Fuzz.map3 Color.rgb (Fuzz.intRange 0 255) (Fuzz.intRange 0 255) (Fuzz.intRange 0 255)
