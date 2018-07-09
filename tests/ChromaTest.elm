module ChromaTest exposing (..)

import Test as Test
import Expect
import Types as Types
import Fuzz as Fuzz
import Color as Color
import UtilTest as Util
import Colors.W3CX11 as W3CX11
import Converter.In.Hex2Rgb as Hex2Rgb
import Chroma as Chroma


tests : Test.Test
tests =
    Test.describe "Chroma API"
        [ testDistance
        ]


c1 =
    Maybe.withDefault (W3CX11.black) (Hex2Rgb.hex3Or6Or8 "#fff")


c2 =
    Maybe.withDefault (W3CX11.black) (Hex2Rgb.hex3Or6Or8 "#ff0")


c3 =
    Maybe.withDefault (W3CX11.black) (Hex2Rgb.hex3Or6Or8 "#f0f")


testDistance : Test.Test
testDistance =
    Test.describe "distance"
        [ Test.test "Distance 1" <|
            \_ ->
                Chroma.distance (Types.ExtColor c1) (Types.ExtColor c2)
                    |> Expect.within (Expect.Absolute 0.001) 255
        , Test.test "Distance 2" <|
            \_ ->
                Chroma.distance (Types.ExtColor c1) (Types.ExtColor c3)
                    |> Expect.within (Expect.Absolute 0.001) 255
        , Test.test "Distance 3" <|
            \_ ->
                Chroma.distanceWithLab (Types.ExtColor c1) (Types.ExtColor c2)
                    |> Expect.within (Expect.Absolute 0.001) 96.948
        , Test.test "Distance 4" <|
            \_ ->
                Chroma.distanceWithLab (Types.ExtColor c1) (Types.ExtColor c3)
                    |> Expect.within (Expect.Absolute 0.001) 122.163
        ]
