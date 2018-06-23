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
    (fromBase16 char1 * 16) + (fromBase16 char2)


fromBase16 char =
    case (Char.toLower char) of
        '0' ->
            0

        '1' ->
            1

        '2' ->
            2

        '3' ->
            3

        '4' ->
            4

        '5' ->
            5

        '6' ->
            6

        '7' ->
            7

        '8' ->
            8

        '9' ->
            9

        'a' ->
            10

        'b' ->
            11

        'c' ->
            12

        'd' ->
            13

        'e' ->
            14

        'f' ->
            15

        nonHex ->
            0


hex3Or6 : String -> Maybe Color
hex3Or6 str =
    let
        allMatches =
            Regex.find Regex.All hex3Or6Regex str

        firstMatch charList =
            case (charList |> List.head) of
                Just '#' ->
                    Just
                        (charList
                            |> List.drop 1
                        )

                _ ->
                    Just charList

        convertToHex6 str =
            case str of
                a :: b :: c :: [] ->
                    Just (rgb (twoBase16 a a) (twoBase16 b b) (twoBase16 c c))

                a :: b :: c :: d :: e :: f :: [] ->
                    Just (rgb (twoBase16 a b) (twoBase16 c d) (twoBase16 e f))

                _ ->
                    Nothing
    in
        firstMatch (String.toList str) |> Maybe.andThen convertToHex6


hex2rgb : String -> Result String Color
hex2rgb str =
    Err ""
