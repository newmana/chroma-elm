module Chroma.Limits.CkMeans exposing (converge, firstLine, getValues, limit)

import Chroma.Limits.Analyze as Analyze
import List.Nonempty as Nonempty


type alias CkElement =
    { sum : Float
    , sumOfSquare : Float
    , element : Float
    , backtrackElement : Float
    }


type alias CkFirstRow =
    { sums : List Float
    , previousSum : Float
    , sumsOfSquares : List Float
    , previousSumsOfSquares : Float
    , firstMatrixRow : List Float
    , firstBackmatrixRow : List Float
    , count : Int
    }


type alias CkResult =
    { sums : Nonempty.Nonempty Float
    , sumsOfSquares : Nonempty.Nonempty Float
    , matrix : Nonempty.Nonempty (Nonempty.Nonempty Float)
    , backmatrix : Nonempty.Nonempty (Nonempty.Nonempty Float)
    }


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


fillMatrices : Analyze.Scale -> CkResult
fillMatrices =
    Debug.todo ""


firstLine : Analyze.Scale -> CkResult
firstLine scale =
    let
        nValues =
            scale.count

        shift =
            Nonempty.get (nValues // 2) scale.values

        firstCkElement =
            firstLineSumSumSquareAndSsq shift 0 (Nonempty.head scale.values) 0 0

        defaultCkFirstRow =
            { sums = []
            , previousSum = firstCkElement.sum
            , sumsOfSquares = []
            , previousSumsOfSquares = firstCkElement.sumOfSquare
            , firstMatrixRow = []
            , firstBackmatrixRow = []
            , count = 1
            }

        calc data acc =
            let
                result =
                    firstLineSumSumSquareAndSsq shift acc.count data acc.previousSum acc.previousSumsOfSquares
            in
            { acc
                | sums = result.sum :: acc.sums
                , previousSum = result.sum
                , sumsOfSquares = result.sumOfSquare :: acc.sumsOfSquares
                , previousSumsOfSquares = result.sumOfSquare
                , firstMatrixRow = result.element :: acc.firstMatrixRow
                , firstBackmatrixRow = result.backtrackElement :: acc.firstBackmatrixRow
                , count = acc.count + 1
            }

        firstRow =
            List.foldl calc defaultCkFirstRow (Nonempty.tail scale.values)
    in
    { sums = Nonempty.Nonempty firstCkElement.sum (List.reverse firstRow.sums)
    , sumsOfSquares = Nonempty.Nonempty firstCkElement.sumOfSquare (List.reverse firstRow.sumsOfSquares)
    , matrix = Nonempty.Nonempty (Nonempty.Nonempty firstCkElement.element (List.reverse firstRow.firstMatrixRow)) []
    , backmatrix = Nonempty.Nonempty (Nonempty.Nonempty firstCkElement.backtrackElement (List.reverse firstRow.firstBackmatrixRow)) []
    }


firstLineSumSumSquareAndSsq : Float -> Int -> Float -> Float -> Float -> CkElement
firstLineSumSumSquareAndSsq shift i data previousSum previousSumSquare =
    let
        shiftedValue =
            data - shift

        sum =
            previousSum + shiftedValue

        sumSquare =
            previousSumSquare + (shiftedValue * shiftedValue)

        newSsq =
            sumSquare - (sum * sum) / (toFloat i + 1)

        backtrack =
            0
    in
    { sum = sum, sumOfSquare = sumSquare, element = newSsq, backtrackElement = backtrack }


fillMatrix : Analyze.Scale -> CkResult -> CkResult
fillMatrix scale result =
    let
        cluster =
            Nonempty.Nonempty 1 (List.range 2 (nValues - 1))

        nValues =
            scale.count

        iMin i =
            if i < (nValues - 1) then
                i

            else
                nValues - 1
    in
    Nonempty.foldl (\index acc -> fillMatrixColumn (iMin index) (nValues - 1) index acc) result cluster


fillMatrixColumn : Int -> Int -> Int -> CkResult -> CkResult
fillMatrixColumn min max cluster result =
    let
        i =
            floor ((min + max |> toFloat) / 2)
    in
    result


fillLineInMatrix : Int -> Int -> Int -> Nonempty.Nonempty Float -> Nonempty.Nonempty Float -> Nonempty.Nonempty Float -> a
fillLineInMatrix i jHigh jLow previousLine sums sumsOfSquares =
    let
        sji j =
            ssq j i sums sumsOfSquares

        sjLowi =
            ssq jLow i sums sumsOfSquares

        ssqj j =
            sji j + Nonempty.get (j - 1) previousLine

        doStuff acc j newValue =
            if sji j + Nonempty.get (jLow - 1) previousLine >= newValue then
                acc

            else
                acc

        newLine =
            List.foldr identity (List.range jHigh jLow)
    in
    Debug.todo ""


converge : Int -> Int -> Int -> Nonempty.Nonempty Float -> Nonempty.Nonempty Float -> Nonempty.Nonempty Float -> ( Float, Int )
converge i low high sums sumsOfSquares previousLine =
    let
        sji j =
            ssq j i sums sumsOfSquares

        sjLowi lowIndex =
            ssq lowIndex i sums sumsOfSquares

        ssqjLow j lowIndex =
            sjLowi lowIndex + Nonempty.get (lowIndex - 1) previousLine

        ssqj j =
            sji j + Nonempty.get (j - 1) previousLine

        calcMatrixAndBacktrackMatrix ( j, lowIndex ) ( done, m, bm ) =
            if (sji j + Nonempty.get (lowIndex - 1) previousLine) >= m then
                ( True, m, bm )

            else if ssqjLow j lowIndex < m then
                ( False, ssqjLow j lowIndex, lowIndex )

            else if ssqj j < m then
                ( False, ssqj j, j )

            else
                ( done, m, bm )

        startM =
            Nonempty.get (i - 1) previousLine

        startBm =
            i

        values =
            getValues low high

        ( _, outM, outBm ) =
            List.foldr calcMatrixAndBacktrackMatrix ( False, startM, startBm ) values
    in
    ( outM, outBm )


getValues : Int -> Int -> List ( Int, Int )
getValues low high =
    let
        mid =
            (low + high |> toFloat) / 2

        lowMid =
            List.range low (floor mid)

        highMid =
            List.range (ceiling mid) high |> List.reverse
    in
    List.map2 Tuple.pair lowMid highMid
