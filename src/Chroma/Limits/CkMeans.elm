module Chroma.Limits.CkMeans exposing (converge, defaultResult, fillRestOfMatrix, firstLine, getValues, limit)

import Array as Array
import Chroma.Limits.Analyze as Analyze
import List.Nonempty as Nonempty


type alias CkElement =
    { sum : Float
    , sumOfSquare : Float
    , element : Float
    , backtrackElement : Int
    }


type alias CkFirstRow =
    { sums : Array.Array Float
    , previousSum : Float
    , sumsOfSquares : Array.Array Float
    , previousSumsOfSquares : Float
    , firstMatrixRow : MatrixLine
    , firstBackmatrixRow : BacktrackMatrixLine
    , count : Int
    }


type alias CkRest =
    { sums : Array.Array Float
    , sumsOfSquares : Array.Array Float
    , matrix : Array.Array MatrixLine
    , previousMatrix : MatrixLine
    , backmatrix : Array.Array BacktrackMatrixLine
    , previousBackmatrix : BacktrackMatrixLine
    }


type alias CkResult =
    { sums : Array.Array Float
    , sumsOfSquares : Array.Array Float
    , matrix : Array.Array MatrixLine
    , backmatrix : Array.Array BacktrackMatrixLine
    }


defaultResult : Int -> Int -> CkResult
defaultResult bins nValues =
    { sums = Array.empty
    , sumsOfSquares = Array.empty
    , matrix = makeMatrix bins nValues (always 0.0)
    , backmatrix = makeMatrix bins nValues (always 0)
    }


type alias BacktrackMatrixLine =
    Array.Array Int


type alias MatrixLine =
    Array.Array Float


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


ssq : Int -> Int -> Array.Array Float -> Array.Array Float -> Float
ssq j i sums sumsOfSquares =
    let
        sji =
            if j > 0 then
                let
                    muji =
                        (Array.get i sums |> Maybe.withDefault 0) + (Array.get (j - 1) sums |> Maybe.withDefault 0) / (i - j + 1 |> toFloat)
                in
                (Array.get i sumsOfSquares |> Maybe.withDefault 0) - ((Array.get (j - 1) sumsOfSquares |> Maybe.withDefault 0) - (i - j + 1 |> toFloat)) * muji * muji

            else
                (Array.get i sumsOfSquares |> Maybe.withDefault 0) - ((Array.get i sums |> Maybe.withDefault 0) * (Array.get i sums |> Maybe.withDefault 0)) / (i + 1 |> toFloat)
    in
    if sji < 0 then
        0

    else
        sji


makeMatrix : Int -> Int -> (Int -> a) -> Array.Array (Array.Array a)
makeMatrix cols rows f =
    let
        newRow =
            Array.initialize rows f
    in
    Array.initialize cols (always newRow)


fillMatrices : Analyze.Scale -> CkResult -> CkResult
fillMatrices scale result =
    Debug.todo ""


firstLine : Int -> Analyze.Scale -> CkRest
firstLine bins scale =
    let
        nValues =
            scale.count

        shift =
            Nonempty.get (nValues // 2) scale.values

        firstCkElement =
            firstLineSumSumSquareAndSsq shift 0 (Nonempty.head scale.values) 0 0

        defaultCkFirstRow =
            { sums = Array.initialize nValues (always firstCkElement.sum)
            , previousSum = firstCkElement.sum
            , sumsOfSquares = Array.initialize nValues (always firstCkElement.sumOfSquare)
            , previousSumsOfSquares = firstCkElement.sumOfSquare
            , firstMatrixRow = Array.initialize nValues (always 0)
            , firstBackmatrixRow = Array.initialize nValues (always 0)
            , count = 1
            }

        calc data acc =
            let
                tmpResult =
                    firstLineSumSumSquareAndSsq shift acc.count data acc.previousSum acc.previousSumsOfSquares
            in
            { acc
                | sums = Array.set acc.count tmpResult.sum acc.sums
                , previousSum = tmpResult.sum
                , sumsOfSquares = Array.set acc.count tmpResult.sumOfSquare acc.sumsOfSquares
                , previousSumsOfSquares = tmpResult.sumOfSquare
                , firstMatrixRow = Array.set acc.count tmpResult.element acc.firstMatrixRow
                , firstBackmatrixRow = Array.set acc.count tmpResult.backtrackElement acc.firstBackmatrixRow
                , count = acc.count + 1
            }

        firstRow =
            List.foldl calc defaultCkFirstRow (Nonempty.tail scale.values)

        defaultMatrix =
            makeMatrix bins nValues (always 0.0)

        defaultBackmatrix =
            makeMatrix bins nValues (always 0)
    in
    { sums = firstRow.sums
    , sumsOfSquares = firstRow.sumsOfSquares
    , matrix = Array.set 0 firstRow.firstMatrixRow defaultMatrix
    , previousMatrix = firstRow.firstMatrixRow
    , backmatrix = Array.set 0 firstRow.firstBackmatrixRow defaultBackmatrix
    , previousBackmatrix = firstRow.firstBackmatrixRow
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


fillRestOfMatrix : Analyze.Scale -> CkRest -> CkResult
fillRestOfMatrix scale rest =
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

        callFill index acc =
            fillMatrixColumn (iMin index) (nValues - 1) index acc

        calcResult =
            Nonempty.foldl callFill rest cluster
    in
    { sums = rest.sums, sumsOfSquares = rest.sumsOfSquares, matrix = calcResult.matrix, backmatrix = calcResult.backmatrix }


fillMatrixColumn : Int -> Int -> Int -> CkRest -> CkRest
fillMatrixColumn iMin iMax cluster rest =
    let
        i =
            floor ((iMin + iMax |> toFloat) / 2)

        low =
            max cluster (Array.get i rest.previousBackmatrix |> Maybe.withDefault 0)

        high =
            i - 1
    in
    if iMin > iMax then
        rest

    else
        let
            ( outM, outBm ) =
                converge i low high rest

            newMatrixLine index value arr =
                Array.get index arr |> Maybe.andThen (\x -> Array.set i value x |> (\y -> Array.set cluster y arr) |> Just)

            newMatrix index value arr =
                Maybe.withDefault arr (newMatrixLine index value arr)

            firstRest =
                { rest | matrix = newMatrix cluster outM rest.matrix, backmatrix = newMatrix cluster outBm rest.backmatrix }

            lessMax =
                fillMatrixColumn iMin (iMax - 1) cluster firstRest

            moreMin =
                fillMatrixColumn (iMin + 1) iMax cluster firstRest
        in
        moreMin


converge : Int -> Int -> Int -> CkRest -> ( Float, Int )
converge i low high rest =
    let
        sji j =
            ssq j i rest.sums rest.sumsOfSquares

        sjLowi lowIndex =
            ssq lowIndex i rest.sums rest.sumsOfSquares

        ssqj j =
            sji j + (Array.get (j - 1) rest.previousMatrix |> Maybe.withDefault 0)

        calcMatrixAndBacktrackMatrix ( j, lowIndex ) ( done, m, bm ) =
            let
                previousMatrixValue =
                    Array.get (lowIndex - 1) rest.previousMatrix |> Maybe.withDefault 0

                ssqjLow =
                    sjLowi lowIndex + previousMatrixValue
            in
            if (sji j + previousMatrixValue) >= m then
                ( True, m, bm )

            else if ssqjLow < m then
                ( False, ssqjLow, lowIndex )

            else if ssqj j < m then
                ( False, ssqj j, j )

            else
                ( done, m, bm )

        startM =
            Array.get (i - 1) rest.previousMatrix |> Maybe.withDefault 0

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
