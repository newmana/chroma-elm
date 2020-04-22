module Chroma.Limits.Matrix exposing (..)

import Array as Array


makeMatrix : Int -> Int -> (Int -> Int -> a) -> Array.Array (Array.Array a)
makeMatrix rows cols f =
    let
        newRow rowIndex =
            Array.initialize cols (f rowIndex)
    in
    Array.initialize rows newRow
