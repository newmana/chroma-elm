module Chroma.Limits.Matrix exposing (..)

import Array as Array


makeMatrix : Int -> Int -> (Int -> Int -> a) -> Array.Array (Array.Array a)
makeMatrix rows cols f =
    let
        newRow rowIndex =
            Array.initialize cols (f rowIndex)
    in
    Array.initialize rows newRow


setMatrixRowCol : Int -> Int -> a -> Array.Array (Array.Array a) -> Array.Array (Array.Array a)
setMatrixRowCol row col value matrix =
    Maybe.withDefault matrix (maybeSetMatrixRow row col value matrix)


maybeSetMatrixRow : Int -> Int -> a -> Array.Array (Array.Array a) -> Maybe (Array.Array (Array.Array a))
maybeSetMatrixRow row col value matrix =
    Array.get row matrix |> Maybe.andThen (\x -> Array.set col value x |> (\y -> Array.set row y matrix) |> Just)
