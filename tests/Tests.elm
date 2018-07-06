module Tests exposing (..)

import Test as Test
import Converter.Cmyk2RgbTest
import Converter.Lab2RgbTest


all : Test.Test
all =
    Test.describe "Chroma-Elm"
        [ Converter.Cmyk2RgbTest.tests
        , Converter.Lab2RgbTest.tests
        ]
