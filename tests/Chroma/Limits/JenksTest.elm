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
        , testBinned
        ]


onlyOne : Nonempty.Nonempty Float
onlyOne =
    Nonempty.Nonempty 1 []


simple : Nonempty.Nonempty Float
simple =
    Nonempty.Nonempty 1 [ 3, 3, 3, 4 ]


simpleStats : Nonempty.Nonempty Float
simpleStats =
    Nonempty.Nonempty -1 [ 2, -1, 2, 4, 5, 6, -1, 2, -1 ]


onedclusterer : Nonempty.Nonempty Float
onedclusterer =
    Nonempty.Nonempty 0.1 [ 1.1, 1.2, 1.6, 2.2, 2.5, 2.7, 2.8, 3, 3.1, 7.1 ]


onedclusterer2 : Nonempty.Nonempty Float
onedclusterer2 =
    Nonempty.Nonempty 518.39 [ 656.4, 735.34, 1532.48, 2443.45 ]


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
        [ Test.test "Only 1" <|
            \_ ->
                Analyze.analyze onlyOne
                    |> Jenks.limit 1
                    |> Expect.equal (Nonempty.Nonempty 1 [])
        , Test.test "Simple 3 breaks" <|
            \_ ->
                Analyze.analyze simple
                    |> Jenks.limit 3
                    |> Expect.equal (Nonempty.Nonempty 1 [ 3, 4 ])
        , Test.test "3 breaks from Simple Stats" <|
            \_ ->
                Analyze.analyze simpleStats
                    |> Jenks.limit 3
                    |> Expect.equal (Nonempty.Nonempty -1 [ 2, 4 ])
        , Test.test "4 breaks from Simple Stats" <|
            \_ ->
                Analyze.analyze simpleStats
                    |> Jenks.limit 4
                    |> Expect.equal (Nonempty.Nonempty -1 [ 2, 4, 5 ])
        , Test.test "4 breaks from oned clustered" <|
            \_ ->
                Analyze.analyze onedclusterer
                    |> Jenks.limit 4
                    |> Expect.equal (Nonempty.Nonempty 0.1 [ 1.1, 2.2, 7.1 ])
        , Test.test "2 breaks from oned clustered" <|
            \_ ->
                Analyze.analyze onedclusterer2
                    |> Jenks.limit 2
                    |> Expect.equal (Nonempty.Nonempty 518.39 [ 1532.48 ])
        ]


testBinned : Test.Test
testBinned =
    Test.describe "Get jenks binned breaks"
        [ Test.test "Simple 3 breaks" <|
            \_ ->
                Analyze.analyze simple
                    |> Jenks.binned 3
                    |> Expect.equal (Nonempty.Nonempty (Array.fromList [ 1 ]) [ Array.fromList [ 3, 3, 3 ], Array.fromList [ 4 ] ])
        , Test.test "3 breaks from Simple Stats" <|
            \_ ->
                Analyze.analyze simpleStats
                    |> Jenks.binned 3
                    |> Expect.equal (Nonempty.Nonempty (Array.fromList [ -1, -1, -1, -1 ]) [ Array.fromList [ 2, 2, 2 ], Array.fromList [ 4, 5, 6 ] ])
        , Test.test "4 breaks from Simple Stats" <|
            \_ ->
                Analyze.analyze simpleStats
                    |> Jenks.binned 4
                    |> Expect.equal (Nonempty.Nonempty (Array.fromList [ -1, -1, -1, -1 ]) [ Array.fromList [ 2, 2, 2 ], Array.fromList [ 4 ], Array.fromList [ 5, 6 ] ])
        , Test.test "2 breaks from oned clustered" <|
            \_ ->
                Analyze.analyze onedclusterer2
                    |> Jenks.binned 2
                    |> Expect.equal (Nonempty.Nonempty (Array.fromList [ 518.39, 656.4, 735.34 ]) [ Array.fromList [ 1532.48, 2443.45 ] ])
        ]
