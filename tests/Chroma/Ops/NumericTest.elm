module Chroma.Ops.NumericTest exposing (tests)

import Chroma.Ops.Numeric as Numeric
import Chroma.Types as Types
import Color
import Expect
import Test


tests : Test.Test
tests =
    Test.describe "Alpha testing"
        [ testColorToNum
        ]


testColorToNum : Test.Test
testColorToNum =
    Test.describe "num"
        [ Test.test "Red" <|
            \_ ->
                Types.RGBAColor (Color.rgb255 255 0 0) |> Numeric.num |> Expect.equal 16711680
        , Test.test "Green" <|
            \_ ->
                Types.RGBAColor (Color.rgb255 0 255 0) |> Numeric.num |> Expect.equal 65280
        , Test.test "Blue" <|
            \_ ->
                Types.RGBAColor (Color.rgb255 0 0 255) |> Numeric.num |> Expect.equal 255
        , Test.test "Black" <|
            \_ ->
                Types.RGBAColor (Color.rgb255 0 0 0) |> Numeric.num |> Expect.equal 0
        ]
