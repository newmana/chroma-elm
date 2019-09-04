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
        , testContrast
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


testContrast : Test.Test
testContrast =
    let
        whiteRed =
            Luminance.contrast (Types.RGBAColor W3CX11.white) (Types.RGBAColor W3CX11.red)

        redWhite =
            Luminance.contrast (Types.RGBAColor W3CX11.red) (Types.RGBAColor W3CX11.white)
    in
    Test.describe "Get Contrast on a Color"
        [ Test.test "maximum" <|
            \_ ->
                Luminance.contrast (Types.RGBAColor W3CX11.white) (Types.RGBAColor W3CX11.black)
                    |> Expect.within (Expect.Absolute 0.1) 21.0
        , Test.test "minimum" <|
            \_ ->
                Luminance.contrast (Types.RGBAColor W3CX11.white) (Types.RGBAColor W3CX11.white)
                    |> Expect.within (Expect.Absolute 0.1) 1.0
        , Test.test "white to red" <|
            \_ ->
                whiteRed
                    |> Expect.within (Expect.Absolute 0.1) 4.0
        , Test.test "red to white or white to read" <|
            \_ ->
                Expect.within (Expect.Absolute 0.001) whiteRed redWhite
        ]


testSettingLuminance : Test.Test
testSettingLuminance =
    Test.describe "Set Alpha on a Color"
        [ Test.test "of rgba white" <|
            \_ ->
                Luminance.setLuminance 0.5 (Types.RGBAColor W3CX11.white)
                    |> ToHex.toHex
                    |> Expect.equal "#bcbcbc"
        , Test.test "of rgba aquamarine" <|
            \_ ->
                Luminance.setLuminance 0.5 (Types.RGBAColor W3CX11.aquamarine)
                    |> ToHex.toHex
                    |> Expect.equal "#67ceab"
        , Test.test "of lab aquamarine" <|
            \_ ->
                Luminance.setLuminance 0.5 (Types.RGBAColor W3CX11.aquamarine |> Colorspace.colorConvert Types.LAB)
                    |> ToHex.toHex
                    |> Expect.equal "#67ceac"
        , Test.test "of hsla aquamarine" <|
            \_ ->
                Luminance.setLuminance 0.5 (Types.RGBAColor W3CX11.aquamarine |> Colorspace.colorConvert Types.HSLA)
                    |> ToHex.toHex
                    |> Expect.equal "#67ceab"
        , Test.test "of rgba hotpink" <|
            \_ ->
                Luminance.setLuminance 0.5 (Types.RGBAColor W3CX11.hotpink)
                    |> ToHex.toHex
                    |> Expect.equal "#ff9dce"
        , Test.test "of rgba darkslateblue" <|
            \_ ->
                Luminance.setLuminance 0.5 (Types.RGBAColor W3CX11.darkslateblue)
                    |> ToHex.toHex
                    |> Expect.equal "#bcb8d5"
        ]
