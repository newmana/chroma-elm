module Converter.In.Hex2Rgb
    exposing
        ( hex2rgb
        , hex3Or6Or8
        )

import List
import Color
import Char


twoBase16To1 : Char -> Char -> Maybe Float
twoBase16To1 char1 char2 =
    Maybe.map (\x -> x / 255) (twoBase16 char1 char2)


twoBase16 : Char -> Char -> Maybe number
twoBase16 char1 char2 =
    Maybe.map2 (\x1 x2 -> x1 * 16 + x2) (fromBase16 char1) (fromBase16 char2)


fromBase16 : Char -> Maybe number
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


hex3Or6Or8 : String -> Maybe Color.Color
hex3Or6Or8 str =
    let
        removeHash charList =
            case List.head charList of
                Just '#' ->
                    Just (List.drop 1 charList)

                _ ->
                    Just charList

        convertFromHex str =
            case str of
                r :: g :: b :: [] ->
                    Maybe.map3 Color.rgb (twoBase16 r r) (twoBase16 g g) (twoBase16 b b)

                r1 :: r2 :: g1 :: g2 :: b1 :: b2 :: [] ->
                    Maybe.map3 Color.rgb (twoBase16 r1 r2) (twoBase16 g1 g2) (twoBase16 b1 b2)

                r1 :: r2 :: g1 :: g2 :: b1 :: b2 :: a1 :: a2 :: [] ->
                    Maybe.map4 Color.rgba (twoBase16 r1 r2) (twoBase16 g1 g2) (twoBase16 b1 b2) (twoBase16To1 a1 a2)

                _ ->
                    Nothing
    in
        removeHash (String.toList str) |> Maybe.andThen convertFromHex


hex2rgb : String -> Result String Color.Color
hex2rgb hex =
    case hex3Or6Or8 hex of
        Just x ->
            Ok x

        Nothing ->
            Err ("unknown color: " ++ hex)
