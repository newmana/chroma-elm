module UtilTest exposing
    ( expectColorResultWithin
    , expectResultWithin
    , hex1
    , hex2
    , hex23Str
    , hex23Value
    , hex3
    , hex6
    , hex8
    , validRgb
    )

import Color as Color
import Expect as Expect
import Fuzz as Fuzz
import Result as Result


validRgb : Fuzz.Fuzzer Color.Color
validRgb =
    Fuzz.map3 Color.rgb (Fuzz.floatRange 0 255) (Fuzz.floatRange 0 255) (Fuzz.floatRange 0 255)


expectResultWithin : Float -> Float -> Result String Float -> Expect.Expectation
expectResultWithin tolerance expectedValue actualValue =
    case actualValue of
        Ok ok ->
            Expect.within (Expect.Absolute tolerance) expectedValue ok

        Err err ->
            Expect.fail err


expectColorResultWithin : Float -> Color.Color -> Color.Color -> Expect.Expectation
expectColorResultWithin tolerance expectedValue actualValue =
    let
        actual =
            Color.toRgba actualValue
    in
    Expect.all
        [ \rgba -> Expect.within (Expect.Absolute tolerance) actual.red rgba.red
        , \rgba -> Expect.within (Expect.Absolute tolerance) actual.green rgba.green
        , \rgba -> Expect.within (Expect.Absolute tolerance) actual.blue rgba.blue
        , \rgba -> Expect.within (Expect.Absolute tolerance) actual.alpha rgba.alpha
        ]
        (Color.toRgba expectedValue)


hex1 : Int -> String
hex1 hexDigit =
    case hexDigit of
        0 ->
            "0"

        1 ->
            "1"

        2 ->
            "2"

        3 ->
            "3"

        4 ->
            "4"

        5 ->
            "5"

        6 ->
            "6"

        7 ->
            "7"

        8 ->
            "8"

        9 ->
            "9"

        10 ->
            "a"

        11 ->
            "b"

        12 ->
            "c"

        13 ->
            "d"

        14 ->
            "e"

        _ ->
            "f"


hex2 : Int -> String
hex2 x =
    hex1 (x // 16) ++ hex1 (remainderBy 16 x)


{-| [0 => 0, 1 => 1 * 16 + 1, 2 => 2 * 16 + 2, ... , 15 => 15 * 16 + 15]
-}
hex23Value : Int -> Int
hex23Value x =
    (x * 16) + x


{-| [0 => 0, 1 => 11x0, 2 => 22x0, ... , 15 => ffx0]
-}
hex23Str : Int -> String
hex23Str x =
    hex23Value x |> hex2


hex3 : Int -> Int -> Int -> String
hex3 r g b =
    hex23Str r ++ hex23Str g ++ hex23Str b


hex6 : Int -> Int -> Int -> String
hex6 r g b =
    hex2 r ++ hex2 g ++ hex2 b


hex8 : Int -> Int -> Int -> Int -> String
hex8 r g b a =
    hex2 r ++ hex2 g ++ hex2 b ++ hex2 a
