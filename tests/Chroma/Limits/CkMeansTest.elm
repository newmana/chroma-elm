module Chroma.Limits.CkMeansTest exposing (tests)

import Array as Array
import Chroma.Limits.Analyze as Analyze
import Chroma.Limits.CkMeans as CkMeans
import Expect
import List.Nonempty as Nonempty
import Test as Test
import UtilTest as UtilTest


tests : Test.Test
tests =
    Test.describe "CkMeans testing"
        [ testLimit
        , testBinned
        ]


simple : Nonempty.Nonempty Float
simple =
    Nonempty.Nonempty 1 [ 3, 3, 3, 4 ]


simpleStats : Nonempty.Nonempty Float
simpleStats =
    Nonempty.Nonempty -1 [ 2, -1, 2, 4, 5, 6, -1, 2, -1 ]


testLimit : Test.Test
testLimit =
    Test.describe "Get ckmeans limit breaks"
        [ Test.test "Simple 3 breaks" <|
            \_ ->
                Analyze.analyze simple
                    |> CkMeans.limit 3
                    |> Expect.equal (Nonempty.Nonempty 1 [ 3, 4 ])
        , Test.test "Simple 4 breaks" <|
            \_ ->
                Analyze.analyze simple
                    |> CkMeans.limit 4
                    |> Expect.equal (Nonempty.Nonempty 1 [ 3, 4 ])
        , Test.test "3 breaks from Simple Stats" <|
            \_ ->
                Analyze.analyze simpleStats
                    |> CkMeans.limit 3
                    |> Expect.equal (Nonempty.Nonempty -1 [ 2, 4 ])
        , Test.test "4 breaks from Simple Stats" <|
            \_ ->
                Analyze.analyze simpleStats
                    |> CkMeans.limit 4
                    |> Expect.equal (Nonempty.Nonempty -1 [ 2, 4, 6 ])
        ]


testBinned : Test.Test
testBinned =
    Test.describe "Get ckmeans binned breaks"
        [ Test.test "Simple 3 breaks" <|
            \_ ->
                Analyze.analyze simple
                    |> CkMeans.binned 3
                    |> Expect.equal (Nonempty.Nonempty (Array.fromList [ 1 ]) [ Array.fromList [ 3, 3, 3 ], Array.fromList [ 4 ] ])
        , Test.test "Simple 4 breaks" <|
            \_ ->
                Analyze.analyze simple
                    |> CkMeans.binned 4
                    |> Expect.equal (Nonempty.Nonempty (Array.fromList [ 1 ]) [ Array.fromList [ 3, 3 ], Array.fromList [ 3 ], Array.fromList [ 4 ] ])
        , Test.test "3 breaks from Simple Stats" <|
            \_ ->
                Analyze.analyze simpleStats
                    |> CkMeans.binned 3
                    |> Expect.equal (Nonempty.Nonempty (Array.fromList [ -1, -1, -1, -1 ]) [ Array.fromList [ 2, 2, 2 ], Array.fromList [ 4, 5, 6 ] ])
        , Test.test "4 breaks from Simple Stats" <|
            \_ ->
                Analyze.analyze simpleStats
                    |> CkMeans.binned 4
                    |> Expect.equal (Nonempty.Nonempty (Array.fromList [ -1, -1, -1, -1 ]) [ Array.fromList [ 2, 2, 2 ], Array.fromList [ 4, 5 ], Array.fromList [ 6 ] ])
        , Test.test "Test 2 breaks when there's only one" <|
            \_ ->
                Analyze.analyze (Nonempty.Nonempty 1 [ 1, 1, 1 ])
                    |> CkMeans.binned 2
                    |> Expect.equal (Nonempty.Nonempty (Array.fromList [ 1, 1, 1, 1 ]) [])
        ]
