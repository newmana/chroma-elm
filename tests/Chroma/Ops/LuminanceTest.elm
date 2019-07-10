module Chroma.Ops.LuminanceTest exposing (tests)

import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Misc.ColorSpace as Colorspace
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Ops.Luminance as Luminance
import Chroma.Types as Types
import Color as Color
import Expect
import Test as Test
import UtilTest as UtilTest


tests : Test.Test
tests =
    Test.describe "Luminance testing"
        [ testLuminance
        , testSettingLuminance
        ]


testLuminance : Test.Test
testLuminance =
    Test.describe "Get Luminance on a Color"
        [ Test.test "of rgba white" <|
            \_ ->
                Luminance.luminance (Types.RGBAColor W3CX11.white)
                    |> Expect.within (Expect.Absolute 0.001) 1.0
        , Test.test "of rgba aquamarine" <|
            \_ ->
                Luminance.luminance (Types.RGBAColor W3CX11.aquamarine)
                    |> Expect.within (Expect.Absolute 0.001) 0.808
        , Test.test "of rgba hotpink" <|
            \_ ->
                Luminance.luminance (Types.RGBAColor W3CX11.hotpink)
                    |> Expect.within (Expect.Absolute 0.001) 0.347
        , Test.test "of rgba darkslateblue" <|
            \_ ->
                Luminance.luminance (Types.RGBAColor W3CX11.darkslateblue)
                    |> Expect.within (Expect.Absolute 0.001) 0.066
        , Test.test "of rgba black" <|
            \_ ->
                Luminance.luminance (Types.RGBAColor W3CX11.black)
                    |> Expect.within (Expect.Absolute 0.001) 0.0
        ]


testSettingLuminance : Test.Test
testSettingLuminance =
    Test.describe "Set Alpha on a Color"
        [ Test.test "of rgba white" <|
            \_ ->
                Luminance.setLuminance (Types.RGBAColor W3CX11.white) 0.5
                    |> ToHex.toHex
                    |> Expect.equal "#bcbcbc"
        , Test.test "of rgba aquamarine" <|
            \_ ->
                Luminance.setLuminance (Types.RGBAColor W3CX11.aquamarine) 0.5
                    |> ToHex.toHex
                    |> Expect.equal "#67ceab"
        , Test.test "of lab aquamarine" <|
            \_ ->
                Luminance.setLuminance (Types.RGBAColor W3CX11.aquamarine |> Colorspace.colorConvert Types.LAB) 0.5
                    |> ToHex.toHex
                    |> Expect.equal "#67ceac"
        , Test.test "of hsla aquamarine" <|
            \_ ->
                Luminance.setLuminance (Types.RGBAColor W3CX11.aquamarine |> Colorspace.colorConvert Types.HSLA) 0.5
                    |> ToHex.toHex
                    |> Expect.equal "#67ceab"
        , Test.test "of rgba hotpink" <|
            \_ ->
                Luminance.setLuminance (Types.RGBAColor W3CX11.hotpink) 0.5
                    |> ToHex.toHex
                    |> Expect.equal "#ff9dce"
        , Test.test "of rgba darkslateblue" <|
            \_ ->
                Luminance.setLuminance (Types.RGBAColor W3CX11.darkslateblue) 0.5
                    |> ToHex.toHex
                    |> Expect.equal "#bcb8d5"
        ]
