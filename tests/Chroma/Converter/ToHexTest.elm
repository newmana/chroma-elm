module Chroma.Converter.ToHexTest exposing (tests)

import Chroma.Converter.In.Cmyk2Rgb as InCmyk
import Chroma.Converter.In.Hsl2Rgb as InHsl
import Chroma.Converter.Out.ToHex as OutHex
import Chroma.Types as Types
import Expect
import Test as Test


tests : Test.Test
tests =
    Test.describe "To Hex String Converter"
        [ testRecordToHex
        ]


testRecordToHex : Test.Test
testRecordToHex =
    Test.describe "color"
        [ Test.test "HSL" <|
            \_ ->
                { hue = 0.333333333333, saturation = 1, lightness = 0.75, alpha = 1.0 }
                    |> InHsl.hsl2rgb
                    |> Types.RGBColor
                    |> OutHex.toHex
                    |> Expect.equal "#80ff80"
        , Test.test "CLMK" <|
            \_ ->
                { cyan = 1, magenta = 0.5, yellow = 0, black = 0.2 }
                    |> InCmyk.cmyk2rgb
                    |> Types.RGBColor
                    |> OutHex.toHex
                    |> Expect.equal "#0066cc"
        ]
