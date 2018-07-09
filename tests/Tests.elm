module Tests exposing (..)

import Test as Test
import ChromaTest
import Converter.Cmyk2RgbTest
import Converter.Lab2RgbTest
import Converter.Hex2RgbTest


all : Test.Test
all =
    Test.describe "Chroma-Elm"
        [ ChromaTest.tests
        , Converter.Cmyk2RgbTest.tests
        , Converter.Hex2RgbTest.tests
        , Converter.Lab2RgbTest.tests
        ]
