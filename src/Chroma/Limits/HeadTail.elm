module Chroma.Limits.HeadTail exposing (limit)

{-| [Head/tail breaks](https://en.wikipedia.org/wiki/Head/tail_Breaks) is a clustering algorithm scheme for data
with a heavy-tailed distribution such as power laws and lognormal distributions


# Definition

@docs limit

-}

import Chroma.Limits.Analyze as Analyze
import List.Nonempty as Nonempty


{-| Create bins number of results using the given scale.
-}
limit : Int -> Analyze.Scale -> Nonempty.Nonempty Float
limit bins scale =
    let
        lengthF =
            scale.count |> toFloat

        avg =
            scale.sum / lengthF

        start =
            Nonempty.Nonempty avg []

        maybeHead =
            Nonempty.toList >> List.filter (\x -> x > avg) >> Nonempty.fromList
    in
    case maybeHead scale.values of
        Nothing ->
            start

        Just nonEmptyHead ->
            if bins == 1 then
                start

            else
                let
                    sum =
                        Nonempty.foldl (+) 0 nonEmptyHead

                    newScale =
                        { min = Nonempty.head nonEmptyHead, max = Nonempty.get -1 nonEmptyHead, sum = sum, values = nonEmptyHead, count = Nonempty.length nonEmptyHead }
                in
                Nonempty.append start (limit (bins - 1) newScale)
