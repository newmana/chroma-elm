module Chroma.Converter.Lab2RgbTest exposing (testLab, tests)

import Chroma.Converter.In.Lab2Rgb as InLab
import Chroma.Converter.Out.ToLab as OutLab
import Chroma.Types as Types
import Color as Color
import Expect
import Fuzz as Fuzz
import Test as Test
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
                    |> Util.expectColorResultWithin 0.0001 testRgb
        ]
