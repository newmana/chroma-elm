module Chroma.Limits.Limits exposing (LimitMode(..), limits)

{-| Main interface to Limits.


# Definition

@docs LimitMode, limits

-}

import Chroma.Limits.Analyze as Analyze
import Chroma.Limits.CkMeans as CkMeans
import Chroma.Limits.Equal as Equal
import Chroma.Limits.Logarithmic as Logarithimic
import Chroma.Limits.Quantile as Quantile
import List.Nonempty as Nonempty


{-| TBD
-}
type LimitMode
    = CkMeans
    | Equal
    | Logarithmic
    | Quantile


{-| Create bins number of results using the given scale, except for CkMeans which can produce fewer bins.
-}
limits : LimitMode -> Int -> Nonempty.Nonempty Float -> Nonempty.Nonempty Float
limits mode bins data =
    let
        scale =
            Analyze.analyze data
    in
    case mode of
        CkMeans ->
            CkMeans.limit bins scale

        Equal ->
            Equal.limit bins scale

        Logarithmic ->
            Logarithimic.limit bins scale

        Quantile ->
            Quantile.limit bins scale
