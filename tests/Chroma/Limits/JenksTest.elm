module Chroma.Limits.JenksTest exposing (tests)

import Array as Array
import Chroma.Limits.Analyze as Analyze
import Chroma.Limits.Jenks as Jenks
import Expect
import List.Nonempty as Nonempty
import Test as Test


tests : Test.Test
tests =
    Test.describe "Jenks testing"
        [ testGetData
        ]


simple : Nonempty.Nonempty Float
simple =
    Nonempty.Nonempty 1 [ 2, 3, 4, 5 ]


testGetData : Test.Test
testGetData =
    Test.describe "Get data"
        [ Test.test "4 breaks from Simple Stats" <|
            \_ ->
                Analyze.analyze simple
                    |> Jenks.limit 4
                    |> Expect.equal (Nonempty.Nonempty 0 [ 0, 1, 1, 1 ])
        ]
