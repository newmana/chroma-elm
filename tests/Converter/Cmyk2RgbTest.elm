module Converter.Cmyk2RgbTest exposing (..)

import Test as Test
import Expect
import Types as Types
import Fuzz as Fuzz
import Color as Color
import Converter.Out.ToLab as OutLab
import Converter.In.Lab2Rgb as InLab


tests : Test.Test
tests =
    Test.describe "Converters"
        [ testLab
        ]


validRgb : Fuzz.Fuzzer Color.Color
validRgb =
    Fuzz.map3 Color.rgb (Fuzz.intRange 0 255) (Fuzz.intRange 0 255) (Fuzz.intRange 0 255)


testLab : Test.Test
testLab =
    Test.describe "lab"
        [ Test.fuzz validRgb "should round trip between RGB and LAB" <|
            \testRgb ->
                Types.ExtColor testRgb
                    |> OutLab.toLab
                    |> InLab.lab2rgb
                    |> Expect.equal testRgb
        ]
