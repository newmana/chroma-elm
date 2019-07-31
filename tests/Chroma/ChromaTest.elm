module Chroma.ChromaTest exposing (tests)

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
        , testScaleAndClasses
        , testDistance
        , testPadding
        , testColors
        , testMix
        , testAverage
        ]


c1 : Result String Types.ExtColor
c1 =
    Hex2Rgb.hex2rgb "#fff" |> Result.map Types.RGBAColor


c2 : Result String Types.ExtColor
c2 =
    Hex2Rgb.hex2rgb "#ff0" |> Result.map Types.RGBAColor


c3 : Result String Types.ExtColor
c3 =
    Hex2Rgb.hex2rgb "#f0f" |> Result.map Types.RGBAColor


testStringToColor : Test.Test
testStringToColor =
    Test.describe "color"
        [ Test.test "Hotpink string" <|
            \_ ->
                "hotpink" |> Chroma.chroma |> Expect.equal (Result.Ok (Types.RGBAColor W3CX11.hotpink))
        , Test.test "Hotpink to hex string" <|
            \_ ->
                "hotpink" |> Chroma.chroma |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#ff69b4")
        , Test.test "A pink hex" <|
            \_ ->
                "#ff3399" |> Chroma.chroma |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#ff3399")
        , Test.test "A pink hex capitals" <|
            \_ ->
                "#FF3399" |> Chroma.chroma |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#ff3399")
        , Test.test "A pink hex with alpha of 1" <|
            \_ ->
                "#ff3399ff" |> Chroma.chroma |> Result.map ToHex.toHexAlpha |> Expect.equal (Result.Ok "#ff3399ff")
        , Test.test "A pink three letter hex" <|
            \_ ->
                "f39" |> Chroma.chroma |> Result.map ToHex.toHex |> Expect.equal (Result.Ok "#ff3399")
        ]


testScaleAndDomain : Test.Test
testScaleAndDomain =
    let
        ( _, f ) =
            Chroma.domain (Nonempty.Nonempty 0.0 [ 100.0 ]) (Nonempty.map Types.RGBAColor Brewer.rdYlGn)

        ( _, g ) =
            Chroma.domain (Nonempty.Nonempty -1192 [ 0, 66 ]) (Nonempty.map Types.RGBAColor (Nonempty.Nonempty (rgb255 216 179 101) [ rgb255 245 245 245, rgb255 90 180 172 ]))
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


testScaleAndClasses : Test.Test
testScaleAndClasses =
    let
        ( orangeRedScale, f ) =
            Chroma.scale (Nonempty.map Types.RGBAColor Brewer.orRd) |> Tuple.first |> Chroma.classes 5
    in
    Test.describe "scale and classes API"
        [ Test.test "Five classes 0.1" <|
            \_ -> Expect.equal [ "#fff7ec", "#fdd49e", "#fc8d59", "#d7301f", "#7f0000" ] (List.map (f >> ToHex.toHex) [ 0.1, 0.3, 0.5, 0.7, 0.9 ])
        ]


testDistance : Test.Test
testDistance =
    Test.describe "distance"
        [ Test.test "Distance 1" <|
            \_ ->
                Result.map2 (Chroma.distance Types.RGBA) c1 c2 |> UtilTest.expectResultWithin 0.001 1
        , Test.test "Distance 2" <|
            \_ ->
                Result.map2 (Chroma.distance Types.RGBA) c1 c3 |> UtilTest.expectResultWithin 0.001 1
        , Test.test "Distance 3" <|
            \_ ->
                Result.map2 Chroma.distance255 c1 c2 |> UtilTest.expectResultWithin 0.001 255
        , Test.test "Distance 4" <|
            \_ ->
                Result.map2 Chroma.distance255 c1 c3 |> UtilTest.expectResultWithin 0.001 255
        , Test.test "Distance 5" <|
            \_ ->
                Result.map2 (Chroma.distance Types.LAB) c1 c2 |> UtilTest.expectResultWithin 0.001 96.948
        , Test.test "Distance 6" <|
            \_ ->
                Result.map2 (Chroma.distance Types.LAB) c1 c3 |> UtilTest.expectResultWithin 0.001 122.163
        ]


testPadding : Test.Test
testPadding =
    let
        ( _, f ) =
            Chroma.scale (Nonempty.map Types.RGBAColor Brewer.rdYlGn) |> Chroma.padding 0.15

        ( _, bothF ) =
            Chroma.scale (Nonempty.map Types.RGBAColor Brewer.rdYlGn) |> Chroma.paddingBoth ( -0.15, 0.15 )
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


testColors : Test.Test
testColors =
    let
        ( _, whiteToBlack ) =
            Chroma.colors 12 (Nonempty.Nonempty (Types.RGBAColor W3CX11.white) [ Types.RGBAColor W3CX11.black ])

        ( _, orangeToRed ) =
            Chroma.colors 5 (Nonempty.map Types.RGBAColor Brewer.orRd)
    in
    Test.describe "colors API"
        [ Test.test "Five orange to red" <|
            \_ ->
                Expect.equal (Nonempty.Nonempty "#fff7ec" [ "#fdd49e", "#fc8d59", "#d7301f", "#7f0000" ]) (Nonempty.map ToHex.toHex orangeToRed)
        , Test.test "Twelve black to white" <|
            \_ ->
                Expect.equal (Nonempty.Nonempty "#ffffff" [ "#e8e8e8", "#d1d1d1", "#b9b9b9", "#a2a2a2", "#8b8b8b", "#747474", "#5d5d5d", "#464646", "#2e2e2e", "#171717", "#000000" ]) (Nonempty.map ToHex.toHex whiteToBlack)
        ]


testMix : Test.Test
testMix =
    Test.describe "mix API"
        [ Test.test "Red to blue 0.25 RGBA" <|
            \_ ->
                Expect.equal (Result.Ok "#bf0040") (Chroma.mixChroma Types.RGBA 0.25 "red" "blue" |> Result.map ToHex.toHex)
        , Test.test "Red to blue 0.5 LCH" <|
            \_ ->
                Expect.equal "#fa0080" (Chroma.mix Types.LCH 0.5 (Types.RGBAColor W3CX11.red) (Types.RGBAColor W3CX11.blue) |> ToHex.toHex)
        ]


testAverage : Test.Test
testAverage =
    let
        grey =
            Types.RGBAColor (Color.rgb255 221 221 221)

        colors =
            Nonempty.Nonempty grey [ Types.RGBAColor W3CX11.yellow, Types.RGBAColor W3CX11.red, Types.RGBAColor W3CX11.teal ]

        strColors =
            Nonempty.Nonempty "#ddd" [ "yellow", "red", "teal" ]
    in
    Test.describe "average API"
        [ Test.test "Average RGBA" <|
            \_ ->
                Expect.equal (Result.Ok "#b79757") (Chroma.averageChroma Types.RGBA strColors |> Result.map ToHex.toHex)
        , Test.test "Average LAB" <|
            \_ ->
                Expect.equal (Result.Ok "#d3a96a") (Chroma.average Types.LAB colors |> Result.map ToHex.toHex)
        ]
