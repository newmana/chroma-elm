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
        [ testInit
        , testGetMatrix
        , testLimit
        ]


simple : Nonempty.Nonempty Float
simple =
    Nonempty.Nonempty 1 [ 3, 3, 3, 4 ]


testInit : Test.Test
testInit =
    Test.describe "Init matrices"
        [ Test.test "Variance" <|
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
        , Test.test "Lower Class Limits" <|
            \_ ->
                Matrix.makeMatrix 6 4 (Jenks.initLowerClassLimits 6)
                    |> Expect.equal
                        (Array.fromList
                            [ Array.fromList [ 0, 0, 0, 0 ]
                            , Array.fromList [ 0, 1, 1, 1 ]
                            , Array.fromList [ 0, 0, 0, 0 ]
                            , Array.fromList [ 0, 0, 0, 0 ]
                            , Array.fromList [ 0, 0, 0, 0 ]
                            , Array.fromList [ 0, 0, 0, 0 ]
                            ]
                        )
        ]


testGetMatrix : Test.Test
testGetMatrix =
    Test.describe "Creating matrices"
        [ Test.test "Variance" <|
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
        , Test.test "Lower Class Limits" <|
            \_ ->
                Analyze.analyze simple
                    |> Jenks.getMatrix 3
                    |> .lowerClassLimits
                    |> Expect.equal
                        (Array.fromList
                            [ Array.fromList [ 0, 0, 0, 0 ]
                            , Array.fromList [ 0, 1, 1, 1 ]
                            , Array.fromList [ 0, 1, 2, 2 ]
                            , Array.fromList [ 0, 1, 2, 2 ]
                            , Array.fromList [ 0, 1, 2, 2 ]
                            , Array.fromList [ 0, 1, 2, 5 ]
                            ]
                        )
        ]


testLimit : Test.Test
testLimit =
    Test.describe "Get ckmeans limit breaks"
        [ Test.test "Simple 3 breaks" <|
            \_ ->
                Analyze.analyze simple
                    |> Jenks.limit 3
                    |> Expect.equal (Nonempty.Nonempty 1 [ 3, 4 ])
        ]
