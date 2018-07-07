module Converter.Cmyk2RgbTest exposing (..)

import Test as Test
import Expect
import Types as Types
import Fuzz as Fuzz
import Color as Color
import UtilTest as Util
import Converter.Out.ToCmyk as OutCmyk
import Converter.In.Cmyk2Rgb as InCmyk


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
                    |> Expect.equal testRgb
        ]
