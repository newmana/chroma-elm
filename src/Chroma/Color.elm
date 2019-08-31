module Chroma.Color exposing (calcDistance, colorToInt, intToColor)

{-| Extensions to the Color library


# Definition

@docs calcDistance, colorToInt, intToColor

-}

import Bitwise exposing (and, shiftLeftBy, shiftRightBy)
import Color exposing (Color, rgb255, toRgba)
import List.Nonempty as Nonempty


{-| TBD
-}
colorToInt : Color -> Int
colorToInt c =
    let
        realColor =
            toRgba c

        rgba255 =
            { red = realColor.red * 255 |> round, green = realColor.green * 255 |> round, blue = realColor.blue * 255 |> round }
    in
    shiftLeftBy 16 rgba255.red + shiftLeftBy 8 rgba255.green + rgba255.blue


{-| TBD
-}
intToColor : Int -> Color
intToColor num =
    let
        b =
            shiftRightBy 16 (and 0x00FF0000 num)

        g =
            shiftRightBy 8 (and 0xFF00 num)

        r =
            and num 0xFF
    in
    rgb255 r g b


{-| TBD
-}
calcDistance : Nonempty.Nonempty Float -> Nonempty.Nonempty Float -> Float
calcDistance list1 list2 =
    Nonempty.map2 (\c1 c2 -> (c1 - c2) ^ 2) list1 list2 |> Nonempty.foldl (+) 0 |> sqrt
