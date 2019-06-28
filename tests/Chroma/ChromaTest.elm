module Chroma.ChromaTest exposing (c1, c2, c3, testDistance, tests)

import Chroma.Chroma as Chroma
import Chroma.Colors.Brewer as Brewer
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.In.Hex2Rgb as Hex2Rgb
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Types as Types
import Color exposing (Color, rgb255)
import Expect as Expect
import List.Nonempty as Nonempty
import Result as Result
import Test as Test
import UtilTest as UtilTest


tests : Test.Test
tests =
    Test.describe "Chroma API"
        [ testStringToColor
        , testScaleAndDomain
        , testDistance
        , testPadding
        ]


c1 : Result String Types.ExtColor
c1 =
    Hex2Rgb.hex2rgb "#fff" |> Result.map Types.RGBColor


c2 : Result String Types.ExtColor
c2 =
    Hex2Rgb.hex2rgb "#ff0" |> Result.map Types.RGBColor


c3 : Result String Types.ExtColor
c3 =
    Hex2Rgb.hex2rgb "#f0f" |> Result.map Types.RGBColor


testStringToColor : Test.Test
testStringToColor =
    Test.describe "color"
        [ Test.test "Hotpink string" <|
            \_ ->
                "hotpink" |> Chroma.chroma |> Expect.equal (Result.Ok (Types.RGBColor W3CX11.hotpink))
        , Test.test "Hotpink to hex string" <|
            \_ ->
                "hotpink" |> Chroma.chroma |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#ff69b4")
        , Test.test "A pink hex" <|
            \_ ->
                "#ff3399" |> Chroma.chroma |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#ff3399")
        , Test.test "A pink three letter hex" <|
            \_ ->
                "f39" |> Chroma.chroma |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#ff3399")
        ]


testScaleAndDomain : Test.Test
testScaleAndDomain =
    let
        ( _, f ) =
            Chroma.domain (Nonempty.Nonempty 0.0 [ 100.0 ]) (Nonempty.map Types.RGBColor Brewer.rdYlGn)

        ( _, g ) =
            Chroma.domain (Nonempty.Nonempty -1192 [ 0, 66 ]) (Nonempty.map Types.RGBColor (Nonempty.Nonempty (rgb255 216 179 101) [ rgb255 245 245 245, rgb255 90 180 172 ]))
    in
    Test.describe "scale and domain API"
        [ Test.test "Simple test" <|
            \_ ->
                Expect.equal "#ffffbf" (ToHex.toHex (f 50))
        , Test.test "Multi Domain Test Negative" <|
            \_ ->
                Expect.equal "#e0c58d" (ToHex.toHex (g -860))
        , Test.test "Multi Domain Test Zero" <|
            \_ ->
                Expect.equal "#f5f5f5" (ToHex.toHex (g 0))
        , Test.test "Multi Domain Test Positive" <|
            \_ ->
                Expect.equal "#afd7d4" (ToHex.toHex (g 30))
        ]


testDistance : Test.Test
testDistance =
    Test.describe "distance"
        [ Test.test "Distance 1" <|
            \_ ->
                Result.map2 Chroma.distance c1 c2 |> UtilTest.expectResultWithin 0.001 1
        , Test.test "Distance 2" <|
            \_ ->
                Result.map2 Chroma.distance c1 c3 |> UtilTest.expectResultWithin 0.001 1
        , Test.test "Distance 3" <|
            \_ ->
                Result.map2 Chroma.distance255 c1 c2 |> UtilTest.expectResultWithin 0.001 255
        , Test.test "Distance 4" <|
            \_ ->
                Result.map2 Chroma.distance255 c1 c3 |> UtilTest.expectResultWithin 0.001 255
        , Test.test "Distance 5" <|
            \_ ->
                Result.map2 Chroma.distanceWithLab c1 c2 |> UtilTest.expectResultWithin 0.001 96.948
        , Test.test "Distance 6" <|
            \_ ->
                Result.map2 Chroma.distanceWithLab c1 c3 |> UtilTest.expectResultWithin 0.001 122.163
        ]


testPadding : Test.Test
testPadding =
    let
        ( _, f ) =
            Chroma.scale (Nonempty.map Types.RGBColor Brewer.rdYlGn) |> Chroma.padding 0.15

        ( _, bothF ) =
            Chroma.scale (Nonempty.map Types.RGBColor Brewer.rdYlGn) |> Chroma.paddingBoth ( -0.15, 0.15 )
    in
    Test.describe "scale and padding API"
        [ Test.test "Padded left" <|
            \_ ->
                Expect.equal "#f67a49" (ToHex.toHex (f 0.1))
        , Test.test "Padded right" <|
            \_ ->
                Expect.equal "#73c364" (ToHex.toHex (f 0.9))
        , Test.test "Padded left both" <|
            \_ ->
                Expect.equal "#a50026" (ToHex.toHex (bothF 0.1))
        , Test.test "Padded right both" <|
            \_ ->
                Expect.equal "#86cb67" (ToHex.toHex (bothF 0.9))
        ]
