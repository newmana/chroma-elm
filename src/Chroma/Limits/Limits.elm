module Chroma.Limits.Limits exposing (LimitMode(..), limits)

import Chroma.Limits.Analyze as Analyze
import Chroma.Limits.CkMeans as CkMeans
import Chroma.Limits.Equal as Equal
import Chroma.Limits.Logarithmic as Logarithimic
import Chroma.Limits.Quantile as Quantile
import List.Nonempty as Nonempty


type LimitMode
    = CkMeans
    | Equal
    | Logarithmic
    | Quantile


limits : Nonempty.Nonempty Float -> LimitMode -> Int -> Nonempty.Nonempty Float
limits data mode bins =
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
