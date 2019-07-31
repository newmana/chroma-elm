module Chroma.Limits.Analyze exposing
    ( analyze
    , Scale, defaultScale, genericLimit
    )

{-| Preprocessing of data values and helper data structures and functions.


# Definition

@docs analyze


# Helpers

@docs Scale, defaultScale, genericLimit

-}

import List.Nonempty as Nonempty


type alias Scale =
    { min : Float
    , max : Float
    , sum : Float
    , values : Nonempty.Nonempty Float
    , count : Int
    }


defaultScale : Scale
defaultScale =
    { min = 0
    , max = 1
    , sum = 1
    , values = Nonempty.Nonempty 0 [ 1 ]
    , count = 2
    }


{-| Given data, create a Scale data structure (min, max, sum, sorted values and number of values).
-}
analyze : Nonempty.Nonempty Float -> Scale
analyze data =
    let
        sorted =
            Nonempty.sort data

        sum =
            Nonempty.foldl (+) 0 data
    in
    { min = Nonempty.head sorted, max = Nonempty.get -1 sorted, sum = sum, values = sorted, count = Nonempty.length data }


genericLimit : Int -> Scale -> (Int -> Float) -> Nonempty.Nonempty Float
genericLimit bins scale calcBin =
    let
        rest =
            if bins == 1 then
                []

            else
                List.map calcBin (1 :: List.range 2 (bins - 1))
    in
    Nonempty.Nonempty scale.min (rest ++ [ scale.max ])
