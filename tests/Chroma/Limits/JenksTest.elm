module Chroma.Limits.JenksTest exposing (tests)

import Array as Array
import Chroma.Limits.Analyze as Analyze
import Chroma.Limits.Jenks as Jenks
import Chroma.Limits.Matrix as Matrix
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
    Nonempty.Nonempty 1 [ 3, 3, 3, 4 ]


testGetData : Test.Test
testGetData =
    Test.describe "Get data"
        [ Test.test "Init variance" <|
            \_ ->
                Matrix.makeMatrix 6 4 (Jenks.initVarianceCombinations 6 4)
                    |> Expect.equal
                        (Array.fromList
                            [ Array.fromList [ 0, 0, 0, 0 ]
                            , Array.fromList [ 0, 0, 0, 0 ]
                            , Array.fromList [ 0, 9999999, 9999999, 9999999 ]
                            , Array.fromList [ 0, 9999999, 9999999, 9999999 ]
                            , Array.fromList [ 0, 9999999, 9999999, 9999999 ]
                            , Array.fromList [ 0, 9999999, 9999999, 9999999 ]
                            ]
                        )
        , Test.test "3 breaks from Simple Stats" <|
            \_ ->
                Analyze.analyze simple
                    |> Jenks.getMatrix 3
                    |> .varianceCombinations
                    |> Expect.equal
                        (Array.fromList
                            [ Array.fromList [ 0, 0, 0, 0 ]
                            , Array.fromList [ 0, 0, 0, 0 ]
                            , Array.fromList [ 0, 2, 0, 0 ]
                            , Array.fromList [ 0, 2.666666666666668, 0, 0 ]
                            , Array.fromList [ 0, 3, 0, 0 ]
                            , Array.fromList [ 0, 4.799999999999997, 0.75, 0 ]
                            ]
                        )
        ]
