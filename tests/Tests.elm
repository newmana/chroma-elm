module Tests exposing (all)

import Chroma.ChromaTest
import Chroma.Converter.Cmyk2RgbTest
import Chroma.Converter.Hex2RgbTest
import Chroma.Converter.Lab2RgbTest
import Chroma.Converter.Lch2LabTest
import Chroma.Converter.ToHexTest
import Chroma.InterpolatorTest
import Chroma.Limits.CkMeansTest
import Chroma.Limits.EqualTest
import Chroma.Limits.LogarithmicTest
import Chroma.Limits.QuantileTest
import Chroma.Ops.AlphaTest
import Chroma.Ops.LightnessTest
import Chroma.Ops.LuminanceTest
import Chroma.Ops.SaturateTest
import Test as Test


all : Test.Test
all =
    Test.describe "Chroma-Elm"
        [ Chroma.ChromaTest.tests
        , Chroma.InterpolatorTest.tests
        , Chroma.Converter.Cmyk2RgbTest.tests
        , Chroma.Converter.Hex2RgbTest.tests
        , Chroma.Converter.Lab2RgbTest.tests
        , Chroma.Converter.Lch2LabTest.tests
        , Chroma.Converter.ToHexTest.tests
        , Chroma.Ops.AlphaTest.tests
        , Chroma.Ops.LightnessTest.tests
        , Chroma.Ops.LuminanceTest.tests
        , Chroma.Ops.SaturateTest.tests
        , Chroma.Limits.CkMeansTest.tests
        , Chroma.Limits.EqualTest.tests
        , Chroma.Limits.LogarithmicTest.tests
        , Chroma.Limits.QuantileTest.tests
        ]
