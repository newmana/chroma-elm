module Tests exposing (all)

import Chroma.ChromaTest
import Chroma.Converter.Cmyk2RgbTest
import Chroma.Converter.Hex2RgbTest
import Chroma.Converter.Lab2RgbTest
import Test as Test


all : Test.Test
all =
    Test.describe "Chroma-Elm"
        [ Chroma.ChromaTest.tests
        , Chroma.Converter.Cmyk2RgbTest.tests
        , Chroma.Converter.Hex2RgbTest.tests
        , Chroma.Converter.Lab2RgbTest.tests
        ]
