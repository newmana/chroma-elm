module Converter.Cmyk2RgbTest exposing (testCymk, tests)

import Color as Color
import Converter.In.Cmyk2Rgb as InCmyk
import Converter.Out.ToCmyk as OutCmyk
import Expect
import Fuzz as Fuzz
import Test as Test
import Types as Types
import UtilTest as Util


tests : Test.Test
tests =
    Test.describe "CYMK Converters"
        [ testCymk
        ]


testCymk : Test.Test
testCymk =
    Test.describe "cmyk"
        [ Test.fuzz Util.validRgb "should round trip between RGB and CYMK" <|
            \testRgb ->
                Types.ExtColor testRgb
                    |> OutCmyk.toCmyk
                    |> InCmyk.cmyk2rgb
                    |> Util.expectColorResultWithin 0.000000001 testRgb
        ]
