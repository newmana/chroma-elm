module Chroma.Converter.Cmyk2RgbTest exposing (tests)

import Chroma.Converter.In.Cmyk2Rgb as InCmyk
import Chroma.Converter.Out.ToCmyk as OutCmyk
import Chroma.Types as Types
import Test
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
                Types.RGBAColor testRgb
                    |> OutCmyk.toCmyk
                    |> InCmyk.cmyk2rgb
                    |> Util.expectColorResultWithin 0.00001 testRgb
        ]
