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


whiteAndBlackLab : Nonempty.Nonempty Types.ExtColor
whiteAndBlackLab =
    Nonempty.Nonempty whiteLab [ blackLab ]


whiteYellowRedBlackLab : Nonempty.Nonempty Types.ExtColor
whiteYellowRedBlackLab =
    Nonempty.Nonempty whiteLab [ yellowLab, redLab, blackLab ]


whiteAndBlackRgb : Nonempty.Nonempty Types.ExtColor
whiteAndBlackRgb =
    Nonempty.Nonempty (Types.ExtColor W3CX11.white) [ Types.ExtColor W3CX11.black ]


whiteYellowRedBlackLabColors : Scale.Data -> Scale.Data
whiteYellowRedBlackLabColors =
    Scale.createData whiteYellowRedBlackLab


expectScaleWithDomain newDomain correctLightness expectedValue =
    let
        newData =
            Scale.defaultData |> Scale.domain newDomain |> whiteYellowRedBlackLabColors |> (\d -> { d | useCorrectLightness = correctLightness })
    in
    case Scale.getColor newData 50 of
        Types.LABColor lab ->
            Expect.within (Expect.Absolute 0.0001) lab.lightness expectedValue

        _ ->
            Expect.fail "Wrong type returned"


testInterpolate : Test.Test
testInterpolate =
    Test.describe "Interpolation"
        [ Test.test "Simple two colour lab" <|
            \_ ->
                case Scale.getColor (Scale.defaultData |> Scale.createData whiteAndBlackLab) 0.5 of
                    Types.LABColor lab ->
                        Expect.within (Expect.Absolute 1.0) lab.lightness 50

                    _ ->
                        Expect.fail "Wrong type returned"
        , Test.test "Hot with no correction lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData |> whiteYellowRedBlackLabColors
                in
                case Scale.getColor newData 0.5 of
                    Types.LABColor lab ->
                        -- CB gets 75.19
                        Expect.within (Expect.Absolute 1.0) lab.lightness 75

                    _ ->
                        Expect.fail "Wrong type returned"
        , Test.test "Hot with correction lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData |> whiteYellowRedBlackLabColors
                in
                case Scale.getColor { newData | useCorrectLightness = True } 0.5 of
                    Types.LABColor lab ->
                        Expect.within (Expect.Absolute 1.0) lab.lightness 50

                    _ ->
                        Expect.fail "Wrong type returned"
        , Test.test "Hot with no correction and domain [0,100] lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData |> Scale.domain (Nonempty.Nonempty 0 [ 100 ]) |> whiteYellowRedBlackLabColors
                in
                case Scale.getColor newData 50 of
                    Types.LABColor lab ->
                        -- CB gets 75.19
                        Expect.within (Expect.Absolute 1.0) lab.lightness 75

                    _ ->
                        Expect.fail "Wrong type returned"

        --        , Test.test "Hot with correction and domain [0,100] lab" <|
        --            \_ ->
        --                let
        --                    newData =
        --                        Scale.defaultData |> Scale.domain (Nonempty.Nonempty 0 [ 100 ]) |> whiteYellowRedBlackLabColors
        --                in
        --                case Scale.getColor { newData | useCorrectLightness = True } 50 of
        --                    Types.LABColor lab ->
        --                        Expect.within (Expect.Absolute 0.0001) lab.lightness 50
        --
        --                    _ ->
        --                        Expect.fail "Wrong type returned"
        , Test.test "Hot with no correction and domain [0,20,40,60,80,100] lab" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData |> Scale.domain (Nonempty.Nonempty 0 [ 20, 40, 60, 80, 100 ]) |> whiteYellowRedBlackLabColors
                in
                case Scale.getColor newData 50 of
                    Types.LABColor lab ->
                        -- CB gets 75.19
                        Expect.within (Expect.Absolute 1.0) lab.lightness 75

                    _ ->
                        Expect.fail "Wrong type returned"

        --        , Test.test "Hot with correction and domain [0,20,40,60,80,100] lab" <|
        --            \_ ->
        --                let
        --                    newData =
        --                        Scale.defaultData |> Scale.domain (Nonempty.Nonempty 0 [ 20, 40, 60, 80, 100 ]) |> whiteYellowRedBlackLabColors
        --
        --                in
        --                case Scale.getColor { newData | useCorrectLightness = True } 50 of
        --                    Types.LABColor lab ->
        --                        Expect.within (Expect.Absolute 0.0001) lab.lightness 49
        --
        --                    _ ->
        --                        Expect.fail "Wrong type returned"
        , Test.test "Simple two colour RGB" <|
            \_ ->
                let
                    newData =
                        Scale.defaultData |> Scale.createData whiteAndBlackRgb
                in
                case Scale.getColor newData 0.25 of
                    Types.ExtColor c ->
                        Color.toRgba c |> (\rgba -> Expect.within (Expect.Absolute 0.0001) rgba.red 0.75)

                    _ ->
                        Expect.fail "Wrong type returned"
        ]
