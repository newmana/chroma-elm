module Chroma.Limits.HeadTailTest exposing (tests)

import Chroma.Limits.Analyze as Analyze
import Chroma.Limits.HeadTail as HeadTail
import Expect
import List.Nonempty as Nonempty
import Test


tests : Test.Test
tests =
    Test.describe "Head/tail testing"
        [ testLimit
        ]


testLimit : Test.Test
testLimit =
    let
        testScale =
            Analyze.analyze (Nonempty.Nonempty 7 [ 2, 1, 3, 2, 5, 4, 6 ])
    in
    Test.describe "Get head tail breaks"
        [ Test.test "1 break" <|
            \_ ->
                HeadTail.limit 1 testScale
                    |> Expect.equal (Nonempty.Nonempty 3.75 [])
        , Test.test "3 break" <|
            \_ ->
                HeadTail.limit 3 testScale
                    |> Expect.equal (Nonempty.Nonempty 3.75 [ 5.5, 6.5 ])
        , Test.test "5 break - maxes out at 4" <|
            \_ ->
                HeadTail.limit 5 testScale
                    |> Expect.equal (Nonempty.Nonempty 3.75 [ 5.5, 6.5, 7.0 ])
        ]
