module Chroma.Limits.Analyze exposing (Scale, analyze, defaultScale)

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


analyze : Nonempty.Nonempty Float -> Scale
analyze data =
    let
        sorted =
            Nonempty.sort data

        sum =
            Nonempty.foldl (+) 0 data
    in
    { min = Nonempty.head sorted, max = Nonempty.get -1 sorted, sum = sum, values = sorted, count = Nonempty.length data }
