module Converter.Lab2RgbTest exposing (testLab, tests)

import Color as Color
import Converter.In.Lab2Rgb as InLab
import Converter.Out.ToLab as OutLab
import Expect
import Fuzz as Fuzz
import Test as Test
import Types as Types
import UtilTest as Util


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
                    |> Util.expectColorResultWithin 0.000000001 testRgb
        ]
