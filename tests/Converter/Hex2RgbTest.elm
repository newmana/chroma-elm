module Converter.Hex2RgbTest exposing (..)

import Test as Test
import Expect
import Types as Types
import Fuzz as Fuzz
import Color as Color
import UtilTest as Util
import Converter.In.Hex2Rgb as Hex2Rgb


tests : Test.Test
tests =
    Test.describe "Hex Converters"
        [ testHex
        ]


threeHex3 : Fuzz.Fuzzer ( Int, Int, Int )
threeHex3 =
    Fuzz.map3 (\x y z -> ( x, y, z )) (Fuzz.intRange 0 15) (Fuzz.intRange 0 15) (Fuzz.intRange 0 15)


threeHex6 : Fuzz.Fuzzer ( Int, Int, Int )
threeHex6 =
    Fuzz.map3 (\x y z -> ( x, y, z )) (Fuzz.intRange 0 255) (Fuzz.intRange 0 255) (Fuzz.intRange 0 255)


threeHex8 : Fuzz.Fuzzer { r : Int, g : Int, b : Int, a : Int }
threeHex8 =
    Fuzz.map4 (\x y z a -> { r = x, g = y, b = z, a = a }) (Fuzz.intRange 0 255) (Fuzz.intRange 0 255) (Fuzz.intRange 0 255) (Fuzz.intRange 0 255)


testHex : Test.Test
testHex =
    Test.describe "Hex2Rgb"
        [ Test.fuzz threeHex3 "should round trip between HEX Triple and RGB" <|
            \( r3, g3, b3 ) ->
                Util.hex3 r3 g3 b3
                    |> Hex2Rgb.hex2rgb
                    |> (\x ->
                            case x of
                                Ok color ->
                                    Color.toRgba color
                                        |> (\{ red, green, blue, alpha } -> Expect.equal ( Util.hex23Value r3, Util.hex23Value g3, Util.hex23Value b3 ) ( round red, round green, round blue ))

                                Err err ->
                                    Expect.fail err
                       )
        , Test.fuzz threeHex6 "should round trip between HEX String and RGB" <|
            \( r, g, b ) ->
                Util.hex6 r g b
                    |> Hex2Rgb.hex2rgb
                    |> (\x ->
                            case x of
                                Ok color ->
                                    Color.toRgba color
                                        |> (\{ red, green, blue, alpha } -> Expect.equal ( r, g, b ) ( round red, round green, round blue ))

                                Err err ->
                                    Expect.fail err
                       )
        , Test.fuzz threeHex8 "should round trip between HEX Quad and RGBA" <|
            \{ r, g, b, a } ->
                Util.hex8 r g b a
                    |> Hex2Rgb.hex2rgb
                    |> (\x ->
                            case x of
                                Ok color ->
                                    Color.toRgba color
                                        |> (\rgbaColor -> Expect.equal { alpha = toFloat a / 255, blue = toFloat b, green = toFloat g, red = toFloat r } rgbaColor)

                                Err err ->
                                    Expect.fail err
                       )
        ]
