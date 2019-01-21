module ChromaTest exposing (c1, c2, c3, testDistance, tests)

import Chroma as Chroma
import Converter.In.Hex2Rgb as Hex2Rgb
import Result as Result
import Test as Test
import Types as Types
import UtilTest as UtilTest


tests : Test.Test
tests =
    Test.describe "Chroma API"
        [ testDistance
        ]


c1 : Result String Types.ExtColor
c1 =
    Hex2Rgb.hex2rgb "#fff" |> Result.map Types.ExtColor


c2 : Result String Types.ExtColor
c2 =
    Hex2Rgb.hex2rgb "#ff0" |> Result.map Types.ExtColor


c3 : Result String Types.ExtColor
c3 =
    Hex2Rgb.hex2rgb "#f0f" |> Result.map Types.ExtColor


testDistance : Test.Test
testDistance =
    Test.describe "distance"
        [ Test.test "Distance 1" <|
            \_ ->
                Result.map2 Chroma.distance c1 c2 |> UtilTest.expectResultWithin 0.001 255
        , Test.test "Distance 2" <|
            \_ ->
                Result.map2 Chroma.distance c1 c3 |> UtilTest.expectResultWithin 0.001 255
        , Test.test "Distance 3" <|
            \_ ->
                Result.map2 Chroma.distanceWithLab c1 c2 |> UtilTest.expectResultWithin 0.001 96.948
        , Test.test "Distance 4" <|
            \_ ->
                Result.map2 Chroma.distanceWithLab c1 c3 |> UtilTest.expectResultWithin 0.001 122.163
        ]
