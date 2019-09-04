module Chroma.Ops.Numeric exposing (num, calcDistance, colorToInt, intToColor)

{-| Extensions to the Color library


# Definition

@docs num, calcDistance, colorToInt, intToColor

-}

import Bitwise exposing (and, shiftLeftBy, shiftRightBy)
import Chroma.Converter.Out.ToRgba as ToRgba
import Chroma.Types as Types
import Color exposing (Color, rgb255, toRgba)
import List.Nonempty as Nonempty


{-| Numeric representation of RGB.

    Color.num (Types.RGBAColor (Color.rgb255 192 192 192))
    --> 12632256 : Int

-}
num : Types.ExtColor -> Int
num ext =
    ToRgba.toRgba255 ext |> (\c -> Color.rgb255 c.red c.green c.blue) |> colorToInt


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
intToColor i =
    let
        b =
            shiftRightBy 16 (and 0x00FF0000 i)

        g =
            shiftRightBy 8 (and 0xFF00 i)

        r =
            and i 0xFF
    in
    rgb255 r g b


{-| TBD
-}
calcDistance : Nonempty.Nonempty Float -> Nonempty.Nonempty Float -> Float
calcDistance list1 list2 =
    Nonempty.map2 (\c1 c2 -> (c1 - c2) ^ 2) list1 list2 |> Nonempty.foldl (+) 0 |> sqrt
