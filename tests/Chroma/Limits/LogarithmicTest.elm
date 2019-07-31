module Chroma.Limits.LogarithmicTest exposing (tests)

import Chroma.Limits.Analyze as Analyze
import Chroma.Limits.Logarithmic as Logarithmic
import Expect
import List.Nonempty as Nonempty
import Test as Test
import UtilTest as UtilTest


tests : Test.Test
tests =
    Test.describe "Logarithmic testing"
        [ testLimit
        ]


testLimit : Test.Test
testLimit =
    Test.describe "Get logarithimic breaks"
        [ Test.test "4 breaks - 1 to 10,000" <|
            \_ ->
                Analyze.analyze (Nonempty.Nonempty 1 [ 10000 ])
                    |> Logarithmic.limit 4
                    |> Expect.all
                        (List.map2
                            (\i v -> Nonempty.get i >> Expect.within (Expect.Absolute 0.0001) v)
                            (List.range 0 4)
                            [ 1, 10, 100, 1000, 10000 ]
                        )
        ]
