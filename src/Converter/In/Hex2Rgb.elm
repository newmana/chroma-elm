module Converter.In.Hex2Rgb
    exposing
        ( hex2rgb
        , hex3Or6
        )

import Regex
import List
import Color exposing (Color, rgb)
import Char


twoBase16 char1 char2 =
    Maybe.map2 (\x1 x2 -> x1 * 16 + x2) (fromBase16 char1) (fromBase16 char2)


fromBase16 char =
    case (Char.toLower char) of
        '0' ->
            Just 0

        '1' ->
            Just 1

        '2' ->
            Just 2

        '3' ->
            Just 3

        '4' ->
            Just 4

        '5' ->
            Just 5

        '6' ->
            Just 6

        '7' ->
            Just 7

        '8' ->
            Just 8

        '9' ->
            Just 9

        'a' ->
            Just 10

        'b' ->
            Just 11

        'c' ->
            Just 12

        'd' ->
            Just 13

        'e' ->
            Just 14

        'f' ->
            Just 15

        nonHex ->
            Nothing


hex3Or6 : String -> Maybe Color
hex3Or6 str =
    let
        removeHash charList =
            case List.head charList of
                Just '#' ->
                    Just (List.drop 1 charList)

                _ ->
                    Just charList

        convertToHex6 str =
            case str of
                a :: b :: c :: [] ->
                    Maybe.map3 rgb (twoBase16 a a) (twoBase16 b b) (twoBase16 c c)

                a :: b :: c :: d :: e :: f :: [] ->
                    Maybe.map3 rgb (twoBase16 a b) (twoBase16 c d) (twoBase16 e f)

                _ ->
                    Nothing
    in
        removeHash (String.toList str) |> Maybe.andThen convertToHex6


hex2rgb : String -> Result String Color
hex2rgb str =
    Err ""
