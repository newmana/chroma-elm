module Chroma.Converter.Cmyk2RgbTest exposing (testCymk, tests)

import Chroma.Converter.In.Cmyk2Rgb as InCmyk
import Chroma.Converter.Out.ToCmyk as OutCmyk
import Chroma.Types as Types
import Color as Color
import Expect
import Fuzz as Fuzz
import Test as Test
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
                Types.RGBColor testRgb
                    |> OutCmyk.toCmyk
                    |> InCmyk.cmyk2rgb
                    |> Util.expectColorResultWithin 0.00001 testRgb
        ]
