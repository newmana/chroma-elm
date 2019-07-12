module Chroma.Limits.Quantile exposing (limit)

import Chroma.Limits.Analyze as Analyze
import List.Nonempty as Nonempty


limit : Int -> Analyze.Scale -> Nonempty.Nonempty Float
limit bins scale =
    let
        getQuantile index =
            let
                p =
                    ((scale.count - 1) * index |> toFloat) / toFloat bins

                pb =
                    floor p

                pr =
                    p - (pb |> toFloat)
            in
            if (pb |> toFloat) == p then
                Nonempty.get pb scale.values

            else
                (Nonempty.get pb scale.values * (1 - pr)) + (Nonempty.get (pb + 1) scale.values * pr)

        rest =
            if bins == 1 then
                []

            else
                List.map (\el -> getQuantile el) (1 :: List.range 2 (bins - 1))
    in
    Nonempty.Nonempty scale.min (rest ++ [ scale.max ])
