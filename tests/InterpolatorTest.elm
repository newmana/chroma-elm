module InterpolatorTest exposing (blackLab, redLab, testInterpolate, tests, whiteLab, yellowLab)

import Color as Color
import Colors.W3CX11 as W3CX11
import Converter.In.Hex2Rgb as Hex2Rgb
import Converter.Out.ToLab as ToLab
import Expect as Expect
import Interpolator as Interpolator
import List.Nonempty as Nonempty
import Result as Result
import Scale as Scale
import Test as Test
import Types as Types


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


whiteAndBlackLab =
    Nonempty.Nonempty whiteLab [ blackLab ]


whiteYellowRedBlackLab =
    Nonempty.Nonempty whiteLab [ yellowLab, redLab, blackLab ]


whiteAndBlackRgb =
    Nonempty.Nonempty (Types.ExtColor W3CX11.white) [ Types.ExtColor W3CX11.black ]


testInterpolate : Test.Test
testInterpolate =
    Test.describe "Interpolation"
        [ Test.test "Simple two colour lab" <|
            \_ ->
                case Scale.getColor (Scale.createData Scale.defaultData whiteAndBlackLab) 0.5 of
                    Types.LABColor lab ->
                        Expect.within (Expect.Absolute 0.0001) lab.lightness 50

                    _ ->
                        Expect.fail "Wrong type returned"
        , Test.test "Hot with no correction lab" <|
            \_ ->
                case Scale.getColor (Scale.createData Scale.defaultData whiteYellowRedBlackLab) 0.5 of
                    Types.LABColor lab ->
                        Expect.within (Expect.Absolute 0.0001) lab.lightness 74

                    _ ->
                        Expect.fail "Wrong type returned"
        , Test.test "Hot with correction lab" <|
            \_ ->
                let
                    newData =
                        Scale.createData Scale.defaultData whiteYellowRedBlackLab
                in
                case Scale.getColor { newData | useCorrectLightness = True } 0.5 of
                    Types.LABColor lab ->
                        Expect.within (Expect.Absolute 0.0001) lab.lightness 50

                    _ ->
                        Expect.fail "Wrong type returned"
        , Test.test "Simple two colour RGB" <|
            \_ ->
                case Scale.getColor (Scale.createData Scale.defaultData whiteAndBlackRgb) 0.25 of
                    Types.ExtColor c ->
                        Color.toRgba c |> (\rgba -> Expect.within (Expect.Absolute 0.0001) rgba.red 0.75)

                    _ ->
                        Expect.fail "Wrong type returned"
        ]
