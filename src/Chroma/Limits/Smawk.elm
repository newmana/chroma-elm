module Chroma.Limits.Smawk exposing (..)

import Array
import Array.Extra as ArrayExtra


collate : List a -> ( List a, List a )
collate =
    List.foldr (\a ( x, y ) -> ( a :: y, x )) ( [], [] )


interleave : List a -> List a -> List a
interleave first second =
    case ( first, second ) of
        ( x :: xs, ys ) ->
            x :: interleave ys xs

        ( [], ys ) ->
            ys



--reduce [] ys _ = ys
--reduce (x:xs) [] _ = reduce xs [x] 1
--reduce xxs@(x:xs) yys@(y:ys) t
-- m' ri y > m' ri y ???
--  | ri <- indexArray rs' (t-1), m' ri y > m' ri y = reduce xxs ys (t-1)
--  | t /= n = reduce xs (x:yys) (t+1)
--  | otherwise = reduce xs yys t


reduce : Int -> Int -> Array.Array number -> Array.Array number -> Array.Array number -> Array.Array number
reduce max i row first second =
    let
        ( x, xs ) =
            ArrayExtra.splitAt 0 first

        ( y, ys ) =
            ArrayExtra.splitAt 0 second

        ( a, b ) =
            ( Array.isEmpty first, Array.isEmpty second )
    in
    case ( a, b ) of
        ( True, False ) ->
            second

        ( False, True ) ->
            reduce max 1 row xs x

        ( True, True ) ->
            let
                ri =
                    Array.get (i - 1) row
            in
            reduce max (i - 1) row first ys

        ( False, False ) ->
            if i /= max then
                reduce max (i + 1) row xs (Array.append x second)

            else
                reduce max i row xs second
