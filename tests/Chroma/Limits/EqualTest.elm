module Chroma.Limits.EqualTest exposing (tests)

import Chroma.Limits.Analyze as Analyze
import Chroma.Limits.Equal as Equal
import Expect
import List.Nonempty as Nonempty
import Test as Test
import UtilTest as UtilTest


tests : Test.Test
tests =
    Test.describe "Equal testing"
        [ testLimit
        ]


testLimit : Test.Test
testLimit =
    Test.describe "Get equal breaks"
        [ Test.test "5 breaks - 0 to 10" <|
            \_ ->
                Analyze.analyze (Nonempty.Nonempty 0 [ 10 ])
                    |> Equal.limit 5
                    |> Expect.equal (Nonempty.Nonempty 0 [ 2, 4, 6, 8, 10 ])
        ]
