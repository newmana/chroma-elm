module Chroma.InterpolatorTest exposing (blackLab, redLab, testInterpolate, tests, whiteLab, yellowLab)

import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.In.Hex2Rgb as Hex2Rgb
import Chroma.Converter.Out.ToLab as ToLab
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
        [ testInterpolate
        ]


whiteLab : Types.ExtColor
whiteLab =
    ToLab.toLabExtColor W3CX11.white


blackLab : Types.ExtColor
blackLab =
    ToLab.toLabExtColor W3CX11.black


yellowLab : Types.ExtColor
yellowLab =
    ToLab.toLabExtColor W3CX11.yellow


redLab : Types.ExtColor
redLab =
    ToLab.toLabExtColor W3CX11.red


whiteAndBlackLab : Scale.Data -> Scale.Data
whiteAndBlackLab =
    Scale.createData (Nonempty.Nonempty whiteLab [ blackLab ])


whiteAndBlackRgb : Scale.Data -> Scale.Data
whiteAndBlackRgb =
    Scale.createData (Nonempty.Nonempty (Types.ExtColor W3CX11.white) [ Types.ExtColor W3CX11.black ])


whiteYellowRedBlackLab : Scale.Data -> Scale.Data
whiteYellowRedBlackLab =
    Scale.createData (Nonempty.Nonempty whiteLab [ yellowLab, redLab, blackLab ])


expectScaleWithDomain newData val expectedValue =
    case Scale.getColor newData val of
        Types.LABColor lab ->
            Expect.within (Expect.Absolute 1.0) lab.lightness expectedValue

        _ ->
            Expect.fail "Wrong type returned"


testInterpolate : Test.Test
testInterpolate =
    Test.describe "Interpolation"
        [ Test.test "Simple two colour lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData |> whiteAndBlackLab
                in
                expectScaleWithDomain newData 0.5 50
        , Test.test "Hot with no correction lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData
                            |> whiteYellowRedBlackLab
                in
                expectScaleWithDomain newData 0.5 75
        , Test.test "Hot with correction lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData
                            |> whiteYellowRedBlackLab
                            |> (\d -> { d | useCorrectLightness = True })
                in
                expectScaleWithDomain newData 0.5 50
        , Test.test "Hot with no correction and domain [0,100] lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData |> Scale.domain (Nonempty.Nonempty 0 [ 100 ]) |> whiteYellowRedBlackLab
                in
                expectScaleWithDomain newData 50 75
        , Test.test "Hot with correction and domain [0,100] lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData
                            |> Scale.domain (Nonempty.Nonempty 0 [ 100 ])
                            |> whiteYellowRedBlackLab
                            |> (\d -> { d | useCorrectLightness = True })
                in
                expectScaleWithDomain newData 50 50
        , Test.test "Hot with no correction and domain [0,20,40,60,80,100] lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData
                            |> Scale.domain (Nonempty.Nonempty 0 [ 20, 40, 60, 80, 100 ])
                            |> whiteYellowRedBlackLab
                in
                expectScaleWithDomain newData 50 75
        , Test.test "Hot with correction and domain [0,20,40,60,80,100] lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData
                            |> Scale.domain (Nonempty.Nonempty 0 [ 20, 40, 60, 80, 100 ])
                            |> whiteYellowRedBlackLab
                            |> (\d -> { d | useCorrectLightness = True })
                in
                expectScaleWithDomain newData 50 50
        , Test.test "Simple two colour RGB" <|
            \_ ->
                case Scale.getColor (whiteAndBlackRgb Scale.defaultData) 0.25 of
                    Types.ExtColor c ->
                        Color.toRgba c |> (\rgba -> Expect.within (Expect.Absolute 0.0001) rgba.red 0.75)

                    _ ->
                        Expect.fail "Wrong type returned"
        ]
