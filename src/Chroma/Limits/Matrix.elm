module Chroma.Limits.Matrix exposing (getRowCol, makeMatrix, setRowCol)

import Array


makeMatrix : Int -> Int -> (Int -> Int -> a) -> Array.Array (Array.Array a)
makeMatrix rows cols f =
    let
        newRow rowIndex =
            Array.initialize cols (f rowIndex)
    in
    Array.initialize rows newRow


setRowCol : Int -> Int -> a -> Array.Array (Array.Array a) -> Array.Array (Array.Array a)
setRowCol row col value matrix =
    Maybe.withDefault matrix (maybeSetMatrixRow row col value matrix)


getRowCol : Int -> Int -> Array.Array (Array.Array a) -> Maybe a
getRowCol row col matrix =
    Array.get row matrix |> Maybe.andThen (\x -> Array.get col x)


maybeSetMatrixRow : Int -> Int -> a -> Array.Array (Array.Array a) -> Maybe (Array.Array (Array.Array a))
maybeSetMatrixRow row col value matrix =
    Array.get row matrix |> Maybe.map (\x -> Array.set col value x |> (\y -> Array.set row y matrix))
