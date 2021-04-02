module Chroma.Converter.Lch2LabTest exposing (tests)

import Chroma.Converter.In.Lab2Lch as InLabLch
import Chroma.Converter.In.Lch2Lab as InLchLab
import Expect
import Test
import UtilTest as Util


tests : Test.Test
tests =
    Test.describe "LCH Converters"
        [ testLab
        ]


testLab : Test.Test
testLab =
    Test.describe "lch"
        [ Test.fuzz Util.validLch "should round trip between LCH and LAB" <|
            \testLch ->
                InLchLab.lch2lab testLch
                    |> InLabLch.lab2lch
                    |> Expect.all
                        [ \newLch -> Expect.within (Expect.Absolute 0.001) testLch.luminance newLch.luminance
                        , \newLch -> Expect.within (Expect.Absolute 0.001) testLch.chroma newLch.chroma
                        , \newLch -> Expect.within (Expect.Absolute 0.001) testLch.hue newLch.hue
                        ]
        ]
