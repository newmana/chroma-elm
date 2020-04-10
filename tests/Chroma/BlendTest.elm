module Chroma.BlendTest exposing (tests)

import Chroma.Blend as Blend
import Chroma.Converter.In.Hex2Rgb as Hex2Rgb
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Types as Types
import Expect as Expect
import Result as Result
import Test as Test


tests : Test.Test
tests =
    Test.describe "Blend Tests"
        [ testMultiply
        , testDarken
        , testLighten
        , testScreen
        , testOverlay
        , testBurn
        , testDodge
        , testExclusion
        ]


c1 : Result String Types.ExtColor
c1 =
    Hex2Rgb.hex2rgb "#4cbbfc" |> Result.map Types.RGBAColor


c2 : Result String Types.ExtColor
c2 =
    Hex2Rgb.hex2rgb "#eeee22" |> Result.map Types.RGBAColor


c3 : Result String Types.ExtColor
c3 =
    Hex2Rgb.hex2rgb "#b83d31" |> Result.map Types.RGBAColor


c4 : Result String Types.ExtColor
c4 =
    Hex2Rgb.hex2rgb "#0da671" |> Result.map Types.RGBAColor


testMultiply : Test.Test
testMultiply =
    Test.describe "multiply"
        [ Test.test "Two colors" <|
            \_ ->
                Result.map2 (Blend.blend Blend.Multiply) c1 c2 |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#47af22")
        , Test.test "Other two colors" <|
            \_ ->
                Result.map2 (Blend.blend Blend.Multiply) c3 c4 |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#092816")
        ]


testDarken : Test.Test
testDarken =
    Test.describe "darken"
        [ Test.test "Two colors" <|
            \_ ->
                Result.map2 (Blend.blend Blend.Darken) c1 c2 |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#4cbb22")
        ]


testLighten : Test.Test
testLighten =
    Test.describe "lighten"
        [ Test.test "Two colors" <|
            \_ ->
                Result.map2 (Blend.blend Blend.Lighten) c1 c2 |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#eeeefc")
        ]


testScreen : Test.Test
testScreen =
    Test.describe "screen"
        [ Test.test "Two colors" <|
            \_ ->
                Result.map2 (Blend.blend Blend.Screen) c3 c4 |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#bcbb8c")
        ]


testOverlay : Test.Test
testOverlay =
    Test.describe "overlay"
        [ Test.test "Two colors" <|
            \_ ->
                Result.map2 (Blend.blend Blend.Overlay) c3 c4 |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#784f2b")
        ]


testBurn : Test.Test
testBurn =
    Test.describe "burn"
        [ Test.test "Two colors" <|
            \_ ->
                Result.map2 (Blend.blend Blend.Burn) c3 c2 |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#e7b800")
        ]


testDodge : Test.Test
testDodge =
    Test.describe "dodge"
        [ Test.test "Two colors" <|
            \_ ->
                Result.map2 (Blend.blend Blend.Dodge) c3 c4 |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#2fda8c")
        ]


testExclusion : Test.Test
testExclusion =
    Test.describe "exclusion"
        [ Test.test "Two colors" <|
            \_ ->
                Result.map2 (Blend.blend Blend.Exclusion) c3 c4 |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#b29477")
        ]
