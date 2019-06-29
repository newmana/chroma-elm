module Chroma.Converter.Lab2RgbTest exposing (tests)

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
        , testLimits
        ]


testLab : Test.Test
testLab =
    Test.describe "lab"
        [ Test.fuzz Util.validRgb "should round trip between RGB and LAB" <|
            \testRgb ->
                Types.RGBColor testRgb
                    |> OutLab.toLab
                    |> InLab.lab2rgb
                    |> Util.expectColorResultWithin 0.0001 testRgb
        ]


testLimits : Test.Test
testLimits =
    Test.describe "lab limits"
        [ Test.test "too low" <|
            \_ ->
                Types.RGBColor (Color.rgb255 -10 0 0)
                    |> OutLab.toLab
                    |> InLab.lab2rgb
                    |> Util.expectColorResultWithin 0.0001 (Color.rgb 0 0 0)
        , Test.test "too high" <|
            \_ ->
                Types.RGBColor (Color.rgb255 300 0 0)
                    |> OutLab.toLab
                    |> InLab.lab2rgb
                    |> Util.expectColorResultWithin 0.0001 (Color.rgb 1 0 0)
        ]
