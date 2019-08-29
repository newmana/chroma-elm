module Chroma.InterpolatorTest exposing (blackLab, redLab, testInterpolate, tests, whiteLab, yellowLab)

import Chroma.Colors.Brewer as Brewer
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Converter.Out.ToLab as ToLab
import Chroma.Converter.Out.ToLch as ToLch
import Chroma.Scale as Scale
import Chroma.Types as Types
import Color as Color
import Expect as Expect
import List.Nonempty as Nonempty
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


expectScaleWithDomainLab data val expectedValue =
    case Scale.getColor data val of
        Types.LABColor lab ->
            Expect.within (Expect.Absolute 1.0) lab.lightness expectedValue

        _ ->
            Expect.fail "Wrong type returned"


expectScaleWithDomainRgb data val expectedValue =
    case Scale.getColor data val of
        Types.RGBAColor c ->
            Color.toRgba c |> (\rgba -> Expect.within (Expect.Absolute 0.0001) rgba.red expectedValue)

        _ ->
            Expect.fail "Wrong type returned"


expectScaleWithDomainLabHex data val expectedValue =
    case Scale.getColor data val of
        (Types.LABColor _) as color ->
            Expect.equal (ToHex.toHex color) expectedValue

        _ ->
            Expect.fail "Wrong type returned"


expectScaleWithDomainLchHex data val expectedValue =
    case Scale.getColor data val of
        (Types.LCHColor _) as color ->
            Expect.equal (ToHex.toHex color) expectedValue

        _ ->
            Expect.fail "Wrong type returned"


expectScaleWithDomainRgbHex data val expectedValue =
    case Scale.getColor data val of
        (Types.RGBAColor _) as color ->
            Expect.equal (ToHex.toHex color) expectedValue

        _ ->
            Expect.fail "Wrong type returned"


testSimpleBlackWhiteRgb : Test.Test
testSimpleBlackWhiteRgb =
    let
        colorsList =
            Nonempty.Nonempty whiteRgb [ blackRgb ]

        newData =
            Scale.createDiscreteColorData colorsList Scale.defaultSharedData
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
        colorsList =
            Nonempty.Nonempty whiteLab [ blackLab ]

        newData =
            Scale.createDiscreteColorData colorsList Scale.defaultSharedData
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
        colorsList =
            Nonempty.Nonempty whiteLch [ blackLch ]

        newData =
            Scale.createDiscreteColorData colorsList Scale.defaultSharedData
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
        colorsList =
            Nonempty.map Types.RGBAColor Brewer.rdYlGn

        newData =
            Scale.createDiscreteColorData colorsList Scale.defaultSharedData
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
        colorList =
            Nonempty.map Types.RGBAColor Brewer.rdYlGn

        newData =
            Scale.defaultData |> (\d -> { d | c = Scale.DiscreteColor colorList }) |> Scale.domain (Nonempty.Nonempty 0 [ 100 ])

        multiDomainColorList =
            Nonempty.Nonempty yellowRgb [ lightGreen, bluishRgb ]

        newDataMultiDomain =
            Scale.defaultData |> (\d -> { d | c = Scale.DiscreteColor multiDomainColorList }) |> Scale.domain (Nonempty.Nonempty 0 [ 0.25, 1 ])

        arbitraryColorList =
            Nonempty.map Types.RGBAColor (Nonempty.Nonempty (Color.rgb255 216 179 101) [ Color.rgb255 245 245 245, Color.rgb255 90 180 172 ])

        newArbitrary =
            Scale.defaultData |> (\d -> { d | c = Scale.DiscreteColor arbitraryColorList }) |> Scale.domain (Nonempty.Nonempty -1192 [ 0, 66 ])
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
                    colorsList =
                        Nonempty.Nonempty whiteLab [ blackLab ]

                    newData =
                        Scale.createDiscreteColorData colorsList Scale.defaultSharedData
                in
                expectScaleWithDomainLab newData 0.5 50
        , Test.test "Hot with no correction lab" <|
            \_ ->
                let
                    colorsList =
                        Nonempty.Nonempty whiteLab [ yellowLab, redLab, blackLab ]

                    newData =
                        Scale.createDiscreteColorData colorsList Scale.defaultSharedData
                in
                expectScaleWithDomainLab newData 0.5 75
        , Test.test "Hot with correction lab" <|
            \_ ->
                let
                    colorsList =
                        Nonempty.Nonempty whiteLab [ yellowLab, redLab, blackLab ]

                    newSharedData =
                        Scale.defaultSharedData
                            |> (\d -> { d | useCorrectLightness = True })

                    newData =
                        Scale.createDiscreteColorData colorsList newSharedData
                in
                expectScaleWithDomainLab newData 0.5 50
        , Test.test "Hot with no correction and domain [0,100] lab" <|
            \_ ->
                let
                    colorsList =
                        Nonempty.Nonempty whiteLab [ yellowLab, redLab, blackLab ]

                    newSharedData =
                        Scale.defaultSharedData

                    newData =
                        Scale.createDiscreteColorData colorsList newSharedData
                            |> Scale.domain (Nonempty.Nonempty 0 [ 100 ])
                in
                expectScaleWithDomainLab newData 50 75
        , Test.test "Hot with correction and domain [0,100] lab" <|
            \_ ->
                let
                    colorsList =
                        Nonempty.Nonempty whiteLab [ yellowLab, redLab, blackLab ]

                    newSharedData =
                        Scale.defaultSharedData
                            |> (\d -> { d | useCorrectLightness = True })

                    newData =
                        Scale.createDiscreteColorData colorsList newSharedData
                            |> Scale.domain (Nonempty.Nonempty 0 [ 100 ])
                in
                expectScaleWithDomainLab newData 50 50
        , Test.test "Hot with no correction and domain [0,20,40,60,80,100] lab" <|
            \_ ->
                let
                    colorsList =
                        Nonempty.Nonempty whiteLab [ yellowLab, redLab, blackLab ]

                    newSharedData =
                        Scale.defaultSharedData

                    newData =
                        Scale.createDiscreteColorData colorsList newSharedData
                            |> Scale.domain (Nonempty.Nonempty 0 [ 20, 40, 60, 80, 100 ])
                in
                expectScaleWithDomainLab newData 50 75
        , Test.test "Hot with correction and domain [0,20,40,60,80,100] lab" <|
            \_ ->
                let
                    colorsList =
                        Nonempty.Nonempty whiteLab [ yellowLab, redLab, blackLab ]

                    newSharedData =
                        Scale.defaultSharedData
                            |> (\d -> { d | useCorrectLightness = True })

                    newData =
                        Scale.createDiscreteColorData colorsList newSharedData
                            |> Scale.domain (Nonempty.Nonempty 0 [ 20, 40, 60, 80, 100 ])
                in
                expectScaleWithDomainLab newData 50 50
        , Test.test "Simple two color RGB" <|
            \_ ->
                let
                    colorsList =
                        Nonempty.Nonempty whiteRgb [ blackRgb ]

                    newData =
                        Scale.createDiscreteColorData colorsList Scale.defaultSharedData
                in
                expectScaleWithDomainRgb newData 0.25 0.75
        ]
