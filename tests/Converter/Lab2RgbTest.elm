module Converter.Lab2RgbTest exposing (..)

import Test as Test
import Expect
import Types as Types
import Fuzz as Fuzz
import Color as Color
import UtilTest as Util
import Converter.Out.ToLab as OutLab
import Converter.In.Lab2Rgb as InLab


tests : Test.Test
tests =
    Test.describe "LAB Converters"
        [ testLab
        ]


testLab : Test.Test
testLab =
    Test.describe "lab"
        [ Test.fuzz Util.validRgb "should round trip between RGB and LAB" <|
            \testRgb ->
                Types.ExtColor testRgb
                    |> OutLab.toLab
                    |> InLab.lab2rgb
                    |> Expect.equal testRgb
        ]
