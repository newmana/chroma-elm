module Chroma.Ops.SaturateTest exposing (tests)

import Chroma.Chroma as Chroma
import Chroma.Converter.Out.ToHex as OutHex
import Chroma.Ops.Saturate as OpsSaturate
import Expect
import Test as Test


tests : Test.Test
tests =
    Test.describe "Saturate testing"
        [ testSaturate
        , testDesaturate
        ]


testSaturate : Test.Test
testSaturate =
    Test.describe "Test saturate"
        [ Test.test "Saturate by 1" <|
            \_ ->
                "slategray"
                    |> Chroma.chroma
                    |> Result.map (OpsSaturate.saturate 1)
                    |> Result.map OutHex.toHex
                    |> Expect.equal (Result.Ok "#4b83ae")
        , Test.test "Saturate by 2" <|
            \_ ->
                "slategray"
                    |> Chroma.chroma
                    |> Result.map (OpsSaturate.saturate 2)
                    |> Result.map OutHex.toHex
                    |> Expect.equal (Result.Ok "#0087cd")
        , Test.test "Saturate by 3" <|
            \_ ->
                "slategray"
                    |> Chroma.chroma
                    |> Result.map (OpsSaturate.saturate 3)
                    |> Result.map OutHex.toHex
                    |> Expect.equal (Result.Ok "#008bec")
        ]


testDesaturate : Test.Test
testDesaturate =
    Test.describe "Test desaturate"
        [ Test.test "Desaturate by 1" <|
            \_ ->
                "hotpink"
                    |> Chroma.chroma
                    |> Result.map (OpsSaturate.desaturate 1)
                    |> Result.map OutHex.toHex
                    |> Expect.equal (Result.Ok "#e77dae")
        , Test.test "Desaturate by 2" <|
            \_ ->
                "hotpink"
                    |> Chroma.chroma
                    |> Result.map (OpsSaturate.desaturate 2)
                    |> Result.map OutHex.toHex
                    |> Expect.equal (Result.Ok "#cd8ca8")
        , Test.test "Desaturate by 3" <|
            \_ ->
                "hotpink"
                    |> Chroma.chroma
                    |> Result.map (OpsSaturate.desaturate 3)
                    |> Result.map OutHex.toHex
                    |> Expect.equal (Result.Ok "#b199a3")
        ]
