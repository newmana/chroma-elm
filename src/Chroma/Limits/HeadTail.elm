module Chroma.Limits.HeadTail exposing (limit)

{-| [Head/tail breaks](https://en.wikipedia.org/wiki/Head/tail_Breaks) is a clustering algorithm scheme for data
with a heavy-tailed distribution such as power laws and lognormal distributions.

This does not set a cutoff based on the percentage of data the head represents but rather you set the number of bins
you would like (like all the others), this is similar to
[CartoDB's Postgresql implementation](]https://github.com/CartoDB/cartodb-postgresql/blob/master/scripts-available/CDB_HeadsTailsBins.sql).


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
