module Chroma.Ops.LightnessTest exposing (tests)

import Chroma.Chroma as Chroma
import Chroma.Converter.Out.ToHex as OutHex
import Chroma.Ops.Lightness as OpsLightness
import Expect
import Test


tests : Test.Test
tests =
    Test.describe "Lightness testing"
        [ testDarken
        , testBrighten
        ]


testDarken : Test.Test
testDarken =
    Test.describe "Test darken"
        [ Test.test "Darken by 1" <|
            \_ ->
                "hotpink"
                    |> Chroma.chroma
                    |> Result.map (OpsLightness.darken 1)
                    |> Result.map OutHex.toHex
                    |> Expect.equal (Result.Ok "#c93384")
        , Test.test "Darken by 2" <|
            \_ ->
                "hotpink"
                    |> Chroma.chroma
                    |> Result.map (OpsLightness.darken 2)
                    |> Result.map OutHex.toHex
                    |> Expect.equal (Result.Ok "#930058")
        , Test.test "Darken by 2.6" <|
            \_ ->
                "hotpink"
                    |> Chroma.chroma
                    |> Result.map (OpsLightness.darken 2.6)
                    |> Result.map OutHex.toHex
                    |> Expect.equal (Result.Ok "#74003f")
        ]


testBrighten : Test.Test
testBrighten =
    Test.describe "Test brighten"
        [ Test.test "Brighten by 1" <|
            \_ ->
                "hotpink"
                    |> Chroma.chroma
                    |> Result.map (OpsLightness.brighten 1)
                    |> Result.map OutHex.toHex
                    |> Expect.equal (Result.Ok "#ff9ce6")
        , Test.test "Brighten by 2" <|
            \_ ->
                "hotpink"
                    |> Chroma.chroma
                    |> Result.map (OpsLightness.brighten 2)
                    |> Result.map OutHex.toHex
                    |> Expect.equal (Result.Ok "#ffd1ff")
        , Test.test "Brighten by 3" <|
            \_ ->
                "hotpink"
                    |> Chroma.chroma
                    |> Result.map (OpsLightness.brighten 3)
                    |> Result.map OutHex.toHex
                    |> Expect.equal (Result.Ok "#ffffff")
        ]
