module Chroma.Limits.LogarithmicTest exposing (tests)

import Chroma.Limits.Analyze as Analyze
import Chroma.Limits.Logarithmic as Logarithmic
import Expect
import List.Nonempty as Nonempty
import Test


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
        , Test.test "4 breaks - 1,1,1,1,1,2,2,2,4,5,6" <|
            \_ ->
                Analyze.analyze (Nonempty.Nonempty 1 [ 1, 2, 1, 2, 4, 5, 6, 1, 2, 1 ])
                    |> Logarithmic.limit 4
                    |> Expect.equal (Nonempty.Nonempty 1 [ 1.5650845800732873, 2.449489742783178, 3.8336586254776344, 6 ])
        ]
