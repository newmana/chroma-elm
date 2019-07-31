module Chroma.Limits.QuantileTest exposing (tests)

import Chroma.Limits.Analyze as Analyze
import Chroma.Limits.Quantile as Quantile
import Expect
import List.Nonempty as Nonempty
import Test as Test
import UtilTest as UtilTest


tests : Test.Test
tests =
    Test.describe "Quantile testing"
        [ testEqual
        ]


testEqual : Test.Test
testEqual =
    Test.describe "Get quantile breaks"
        [ Test.test "2 breaks - 1,2,3,4,5,10,20,100" <|
            \_ ->
                Analyze.analyze (Nonempty.Nonempty 1 [ 2, 3, 4, 5, 10, 20, 100 ])
                    |> Quantile.limit 2
                    |> Expect.equal (Nonempty.Nonempty 1 [ 4.5, 100 ])
        ]
