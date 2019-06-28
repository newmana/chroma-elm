module Chroma.Ops.AlphaTest exposing (tests)

import Chroma.Chroma as Chroma
import Chroma.Converter.Out.ToHex as OutHex
import Chroma.Ops.Alpha as OpsAlpha
import Chroma.Types as Types
import Color as Color
import Expect
import Test as Test
import UtilTest as UtilTest


tests : Test.Test
tests =
    Test.describe "Alpha testing"
        [ testGettingAlpha
        , testSettingAlpha
        ]


testGettingAlpha : Test.Test
testGettingAlpha =
    Test.describe "Get Alpha on a Color"
        [ Test.test "of rgba color" <|
            \_ ->
                Types.RGBColor (Color.rgba 255 0 0 0.35)
                    |> OpsAlpha.alpha
                    |> Expect.within (Expect.Absolute 0.0001) 0.35
        , Test.test "of red as a string, alpha 1" <|
            \_ ->
                "ff0000ff"
                    |> Chroma.chroma
                    |> Result.map OpsAlpha.alpha
                    |> UtilTest.expectResultWithin 0.01 1.0
        , Test.test "of red as a string, alpha 0.5ish" <|
            \_ ->
                "ff000080"
                    |> Chroma.chroma
                    |> Result.map OpsAlpha.alpha
                    |> UtilTest.expectResultWithin 0.01 0.5
        ]


testSettingAlpha : Test.Test
testSettingAlpha =
    Test.describe "Set Alpha on a Color"
        [ Test.test "of red" <|
            \_ ->
                "red"
                    |> Chroma.chroma
                    |> Result.map (OpsAlpha.setAlpha 0.5)
                    |> Result.map OutHex.toHexAlpha
                    |> Expect.equal (Result.Ok "#ff000080")
        ]
