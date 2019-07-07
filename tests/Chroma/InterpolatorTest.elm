module Chroma.InterpolatorTest exposing (blackLab, redLab, testInterpolate, tests, whiteLab, yellowLab)

import Chroma.Colors.Brewer as Brewer
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.In.Hex2Rgb as Hex2Rgb
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Converter.Out.ToLab as ToLab
import Chroma.Converter.Out.ToLch as ToLch
import Chroma.Interpolator as Interpolator
import Chroma.Scale as Scale
import Chroma.Types as Types
import Color as Color
import Expect as Expect
import List.Nonempty as Nonempty
import Result as Result
import Test as Test


tests : Test.Test
tests =
    Test.describe "Interpolate API"
        [ testSimpleBlackWhiteRgb
        , testSimpleBlackWhiteLab
        , testBrewerRgb
        , testBrewerRgbWithDomain
        , testInterpolate
        ]


whiteLab : Types.ExtColor
whiteLab =
    Types.RGBAColor W3CX11.white |> ToLab.toLabExt


blackLab : Types.ExtColor
blackLab =
    Types.RGBAColor W3CX11.black |> ToLab.toLabExt


whiteLch : Types.ExtColor
whiteLch =
    Types.RGBAColor W3CX11.white |> ToLch.toLchExt


blackLch : Types.ExtColor
blackLch =
    Types.RGBAColor W3CX11.black |> ToLch.toLchExt


whiteRgb : Types.ExtColor
whiteRgb =
    Types.RGBAColor W3CX11.white


blackRgb : Types.ExtColor
blackRgb =
    Types.RGBAColor W3CX11.black


yellowLab : Types.ExtColor
yellowLab =
    Types.RGBAColor W3CX11.yellow |> ToLab.toLabExt


yellowRgb : Types.ExtColor
yellowRgb =
    Types.RGBAColor W3CX11.yellow


lightGreen : Types.ExtColor
lightGreen =
    Types.RGBAColor W3CX11.lightgreen


bluishRgb : Types.ExtColor
bluishRgb =
    Types.RGBAColor (Color.rgb255 0 138 229)


redLab : Types.ExtColor
redLab =
    Types.RGBAColor W3CX11.red |> ToLab.toLabExt


whiteAndBlackLab : Scale.Data -> Scale.Data
whiteAndBlackLab =
    Scale.createData (Nonempty.Nonempty whiteLab [ blackLab ])


whiteAndBlackLch : Scale.Data -> Scale.Data
whiteAndBlackLch =
    Scale.createData (Nonempty.Nonempty whiteLch [ blackLch ])


whiteAndBlackRgb : Scale.Data -> Scale.Data
whiteAndBlackRgb =
    Scale.createData (Nonempty.Nonempty whiteRgb [ blackRgb ])


yellowAndBluishRgb : Scale.Data -> Scale.Data
yellowAndBluishRgb =
    Scale.createData (Nonempty.Nonempty yellowRgb [ bluishRgb ])


whiteYellowRedBlackLab : Scale.Data -> Scale.Data
whiteYellowRedBlackLab =
    Scale.createData (Nonempty.Nonempty whiteLab [ yellowLab, redLab, blackLab ])


expectScaleWithDomainLab newData val expectedValue =
    case Scale.getColor newData val of
        Types.LABColor lab ->
            Expect.within (Expect.Absolute 1.0) lab.lightness expectedValue

        _ ->
            Expect.fail "Wrong type returned"


expectScaleWithDomainRgb newData val expectedValue =
    case Scale.getColor newData val of
        Types.RGBAColor c ->
            Color.toRgba c |> (\rgba -> Expect.within (Expect.Absolute 0.0001) rgba.red 0.75)

        _ ->
            Expect.fail "Wrong type returned"


expectScaleWithDomainLabHex newData val expectedValue =
    case Scale.getColor newData val of
        (Types.LABColor _) as color ->
            Expect.equal (ToHex.toHex color) expectedValue

        _ ->
            Expect.fail "Wrong type returned"


expectScaleWithDomainLchHex newData val expectedValue =
    case Scale.getColor newData val of
        (Types.LCHColor _) as color ->
            Expect.equal (ToHex.toHex color) expectedValue

        _ ->
            Expect.fail "Wrong type returned"


expectScaleWithDomainRgbHex newData val expectedValue =
    case Scale.getColor newData val of
        (Types.RGBAColor _) as color ->
            Expect.equal (ToHex.toHex color) expectedValue

        _ ->
            Expect.fail "Wrong type returned"


testSimpleBlackWhiteRgb : Test.Test
testSimpleBlackWhiteRgb =
    let
        newData =
            Scale.defaultData |> whiteAndBlackRgb
    in
    Test.describe "Simple RGB Scale"
        [ Test.test "Test start of two" <|
            \_ ->
                expectScaleWithDomainRgbHex newData 0 "#ffffff"
        , Test.test "Test between two" <|
            \_ ->
                expectScaleWithDomainRgbHex newData 0.5 "#808080"
        , Test.test "Test end of two" <|
            \_ ->
                expectScaleWithDomainRgbHex newData 1.0 "#000000"
        ]


testSimpleBlackWhiteLab : Test.Test
testSimpleBlackWhiteLab =
    let
        newData =
            Scale.defaultData |> whiteAndBlackLab
    in
    Test.describe "Simple LAB Scale"
        [ Test.test "Test start of two" <|
            \_ ->
                expectScaleWithDomainLabHex newData 0 "#ffffff"
        , Test.test "Test between two" <|
            \_ ->
                expectScaleWithDomainLabHex newData 0.5 "#777777"
        , Test.test "Test end of two" <|
            \_ ->
                expectScaleWithDomainLabHex newData 1.0 "#000000"
        ]


testSimpleBlackWhiteLch : Test.Test
testSimpleBlackWhiteLch =
    let
        newData =
            Scale.defaultData |> whiteAndBlackLch
    in
    Test.describe "Simple LCH Scale"
        [ Test.test "Test start of two" <|
            \_ ->
                expectScaleWithDomainLchHex newData 0 "#ffffff"
        , Test.test "Test between two" <|
            \_ ->
                expectScaleWithDomainLchHex newData 0.5 "#777777"
        , Test.test "Test end of two" <|
            \_ ->
                expectScaleWithDomainLchHex newData 1.0 "#000000"
        ]


testBrewerRgb : Test.Test
testBrewerRgb =
    let
        newData =
            Scale.defaultData |> Scale.createData (Nonempty.map Types.RGBAColor Brewer.rdYlGn)
    in
    Test.describe "Brewer Red Yellow Green Scale"
        [ Test.test "Test start of two" <|
            \_ ->
                expectScaleWithDomainRgbHex newData 0 "#a50026"
        , Test.test "Test between two" <|
            \_ ->
                expectScaleWithDomainRgbHex newData 0.5 "#ffffbf"
        , Test.test "Test end of two" <|
            \_ ->
                expectScaleWithDomainRgbHex newData 1.0 "#006837"
        ]


testBrewerRgbWithDomain : Test.Test
testBrewerRgbWithDomain =
    let
        newData =
            Scale.defaultData |> Scale.createData (Nonempty.map Types.RGBAColor Brewer.rdYlGn) |> Scale.domain (Nonempty.Nonempty 0 [ 100 ])

        newDataMultiDomain =
            Scale.defaultData |> Scale.createData (Nonempty.Nonempty yellowRgb [ lightGreen, bluishRgb ]) |> Scale.domain (Nonempty.Nonempty 0 [ 0.25, 1 ])

        newArbitrary =
            Scale.defaultData |> Scale.createData (Nonempty.map Types.RGBAColor (Nonempty.Nonempty (Color.rgb255 216 179 101) [ Color.rgb255 245 245 245, Color.rgb255 90 180 172 ])) |> Scale.domain (Nonempty.Nonempty -1192 [ 0, 66 ])
    in
    Test.describe "Brewer Red Yellow Green Scale with 0,100 domain "
        [ Test.test "Test start of two" <|
            \_ ->
                expectScaleWithDomainRgbHex newData 0 "#a50026"
        , Test.test "Test at 10%" <|
            \_ ->
                expectScaleWithDomainRgbHex newData 10 "#d73027"
        , Test.test "Test between two" <|
            \_ ->
                expectScaleWithDomainRgbHex newData 50 "#ffffbf"
        , Test.test "Test end of two" <|
            \_ ->
                expectScaleWithDomainRgbHex newData 100 "#006837"
        , Test.test "Three color RGB start" <|
            \_ ->
                expectScaleWithDomainRgbHex newDataMultiDomain 0.0 (ToHex.toHex yellowRgb)
        , Test.test "Three color RGB on second" <|
            \_ ->
                expectScaleWithDomainRgbHex newDataMultiDomain 0.25 (ToHex.toHex lightGreen)
        , Test.test "Three color RGB midpoint" <|
            \_ ->
                expectScaleWithDomainRgbHex newDataMultiDomain 0.5 "#60cdac"
        , Test.test "Three color RGB end" <|
            \_ ->
                expectScaleWithDomainRgbHex newDataMultiDomain 1.0 (ToHex.toHex bluishRgb)
        , Test.test "Multi Domain Test Arbitrary" <|
            \_ ->
                expectScaleWithDomainRgbHex newArbitrary -860 "#e0c58d"
        ]


testInterpolate : Test.Test
testInterpolate =
    Test.describe "Interpolation"
        [ Test.test "Simple two color lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData |> whiteAndBlackLab
                in
                expectScaleWithDomainLab newData 0.5 50
        , Test.test "Hot with no correction lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData
                            |> whiteYellowRedBlackLab
                in
                expectScaleWithDomainLab newData 0.5 75
        , Test.test "Hot with correction lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData
                            |> whiteYellowRedBlackLab
                            |> (\d -> { d | useCorrectLightness = True })
                in
                expectScaleWithDomainLab newData 0.5 50
        , Test.test "Hot with no correction and domain [0,100] lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData |> Scale.domain (Nonempty.Nonempty 0 [ 100 ]) |> whiteYellowRedBlackLab
                in
                expectScaleWithDomainLab newData 50 75
        , Test.test "Hot with correction and domain [0,100] lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData
                            |> Scale.domain (Nonempty.Nonempty 0 [ 100 ])
                            |> whiteYellowRedBlackLab
                            |> (\d -> { d | useCorrectLightness = True })
                in
                expectScaleWithDomainLab newData 50 50
        , Test.test "Hot with no correction and domain [0,20,40,60,80,100] lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData
                            |> Scale.domain (Nonempty.Nonempty 0 [ 20, 40, 60, 80, 100 ])
                            |> whiteYellowRedBlackLab
                in
                expectScaleWithDomainLab newData 50 75
        , Test.test "Hot with correction and domain [0,20,40,60,80,100] lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData
                            |> Scale.domain (Nonempty.Nonempty 0 [ 20, 40, 60, 80, 100 ])
                            |> whiteYellowRedBlackLab
                            |> (\d -> { d | useCorrectLightness = True })
                in
                expectScaleWithDomainLab newData 50 50
        , Test.test "Simple two color RGB" <|
            \_ ->
                expectScaleWithDomainRgb (whiteAndBlackRgb Scale.defaultData) 0.25 0.75
        ]
