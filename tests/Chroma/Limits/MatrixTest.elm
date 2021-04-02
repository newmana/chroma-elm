module Chroma.Limits.MatrixTest exposing (tests)

import Array
import Chroma.Limits.Matrix as Matrix
import Expect
import Fuzz
import Random
import Shrink
import Test


tests : Test.Test
tests =
    Test.describe "Matrix"
        [ testSetGet
        ]


type alias MatrixTester =
    { matrix : Array.Array (Array.Array Int)
    , row : Int
    , col : Int
    , value : Int
    }


newMatrix : Fuzz.Fuzzer MatrixTester
newMatrix =
    let
        rowAndGetRow =
            Random.int 2 10 |> Random.andThen (\x -> Random.map2 Tuple.pair (Random.constant x) (newRange (x - 1)))

        colAndGetCol =
            Random.int 2 10 |> Random.andThen (\x -> Random.map2 Tuple.pair (Random.constant x) (newRange (x - 1)))

        setValue =
            Random.int 11 20

        makeMatrix r c =
            Matrix.makeMatrix r c (\_ -> always 0)

        generator =
            Random.map3 (\( r, br ) ( c, bc ) v -> { matrix = makeMatrix r c, row = br, col = bc, value = v }) rowAndGetRow colAndGetCol setValue

        shrinker =
            \{ matrix, row, col, value } ->
                Shrink.map MatrixTester (Shrink.array (Shrink.array Shrink.int) matrix)
                    |> Shrink.andMap (Shrink.int row)
                    |> Shrink.andMap (Shrink.int col)
                    |> Shrink.andMap (Shrink.int value)
    in
    Fuzz.custom generator shrinker


newRange : Int -> Random.Generator Int
newRange max =
    Random.int 1 max


testSetGet : Test.Test
testSetGet =
    Test.describe "set and get values"
        [ Test.fuzz newMatrix "should round trip between get and set" <|
            \tester ->
                let
                    setMetrix =
                        Matrix.setRowCol tester.row tester.col tester.value tester.matrix
                in
                Expect.equal (Matrix.getRowCol tester.row tester.col setMetrix) (Just tester.value)
        ]
