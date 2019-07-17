module Chroma.Limits.CkMeans exposing (limit)

import Chroma.Limits.Analyze as Analyze
import List.Nonempty as Nonempty


limit : Int -> Analyze.Scale -> Nonempty.Nonempty Float
limit bins scale =
    let
        numberUnique =
            Nonempty.uniq scale.values |> Nonempty.length
    in
    if numberUnique == 1 then
        scale.values

    else
        Debug.todo ""


fillMatrices : Analyze.Scale -> List (List Float)
fillMatrices scale =
    let
        nValues =
            scale.count

        shift =
            Nonempty.get (nValues // 2) scale.values

        init el =
            let
                shiftedValue =
                    Nonempty.get el scale.values - shift
            in
            if el == 0 then
                shiftedValue

            else
                Nonempty.get (el - 1) scale.values + shiftedValue

        sums =
            Nonempty.map (\el -> init el) (Nonempty.Nonempty 0 (List.range 1 (nValues - 1)))

        sumsOfSquares =
            Nonempty.map (\el -> el * el) sums
    in
    Debug.todo ""


ssq : Int -> Int -> Nonempty.Nonempty Float -> Nonempty.Nonempty Float -> Float
ssq j i sums sumsOfSquares =
    let
        sji =
            if j > 0 then
                let
                    muji =
                        Nonempty.get i sums + Nonempty.get (j - 1) sums / (i - j + 1 |> toFloat)
                in
                Nonempty.get i sumsOfSquares - Nonempty.get (j - 1) sumsOfSquares - (i - j + 1 |> toFloat) * muji * muji

            else
                Nonempty.get i sumsOfSquares - (Nonempty.get i sums * Nonempty.get i sums) / (i + 1 |> toFloat)
    in
    if sji < 0 then
        0

    else
        sji
