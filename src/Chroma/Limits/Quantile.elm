module Chroma.Limits.Quantile exposing (limit)

{-| Create groups that contain an equal number of values.


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
        calcBin el =
            let
                p =
                    ((scale.count - 1) * el |> toFloat) / toFloat bins

                pb =
                    floor p

                pbFloat =
                    toFloat pb
            in
            if pbFloat == p then
                Nonempty.get pb scale.values

            else
                let
                    pr =
                        p - pbFloat
                in
                (Nonempty.get pb scale.values * (1 - pr)) + (Nonempty.get (pb + 1) scale.values * pr)
    in
    Analyze.genericLimit bins scale calcBin
