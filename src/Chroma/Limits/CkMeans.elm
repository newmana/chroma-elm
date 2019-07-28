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
                        ((Array.get i sums |> Maybe.withDefault 0) - (Array.get (j - 1) sums |> Maybe.withDefault 0)) / (i - j + 1 |> toFloat)
                in
                (Array.get i sumsOfSquares |> Maybe.withDefault 0) - (Array.get (j - 1) sumsOfSquares |> Maybe.withDefault 0) - (i - j + 1 |> toFloat) * muji * muji

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


fillRestOfMatrix : Int -> Analyze.Scale -> CkRest -> CkResult
fillRestOfMatrix bins scale rest =
    let
        cluster =
            List.range 1 (bins - 1)

        iMin i =
            if i < (bins - 1) then
                i

            else
                scale.count - 1

        callFill index acc =
            let
                next =
                    fillMatrixColumn (iMin index) (scale.count - 1) index acc
            in
            next

        calcResult =
            List.foldl callFill rest cluster
    in
    { sums = rest.sums, sumsOfSquares = rest.sumsOfSquares, matrix = calcResult.matrix, backmatrix = calcResult.backmatrix }


fillMatrixColumn : Int -> Int -> Int -> CkRest -> CkRest
fillMatrixColumn iMin iMax cluster rest =
    if iMin > iMax then
        rest

    else
        let
            i =
                floor ((iMin + iMax |> toFloat) / 2)

            getOrZero firstIndex secondIndex arrayOfArray =
                case Array.get firstIndex arrayOfArray of
                    Nothing ->
                        0

                    Just line ->
                        Array.get secondIndex line |> Maybe.withDefault 0

            newMatrixLine index value arr =
                Array.get index arr |> Maybe.andThen (\x -> Array.set i value x |> (\y -> Array.set cluster y arr) |> Just)

            newMatrix index value arr =
                Maybe.withDefault arr (newMatrixLine index value arr)

            startMatrixValue =
                Array.get (i - 1) rest.previousMatrix |> Maybe.withDefault 0

            startMatrix =
                newMatrix cluster startMatrixValue rest.matrix

            startBackMatrix =
                newMatrix cluster i rest.backmatrix

            initRest =
                { rest
                    | matrix = startMatrix
                    , backmatrix = startBackMatrix
                }

            prevLow =
                if iMin > cluster then
                    max cluster (getOrZero cluster (iMin - 1) initRest.backmatrix)

                else
                    cluster

            low =
                max prevLow (Array.get i initRest.previousBackmatrix |> Maybe.withDefault 0)

            prevHigh =
                i - 1

            high =
                if iMax < Array.length rest.matrix - 1 then
                    min prevHigh (getOrZero cluster (iMax + 1) initRest.backmatrix)

                else
                    prevHigh

            ( outM, outBm ) =
                converge i low high startMatrixValue initRest

            resultRest =
                { initRest
                    | matrix = newMatrix cluster outM initRest.matrix
                    , backmatrix = newMatrix cluster outBm initRest.backmatrix
                }

            maxOne =
                fillMatrixColumn iMin (i - 1) cluster resultRest

            minOne =
                fillMatrixColumn (i + 1) iMax cluster maxOne
        in
        minOne


converge : Int -> Int -> Int -> Float -> CkRest -> ( Float, Int )
converge i low high startValue rest =
    let
        sji j =
            ssq j i rest.sums rest.sumsOfSquares

        calcMatrixAndBacktrackMatrix ( j, lowIndex ) ( done, m, bm ) =
            let
                sjij =
                    sji j

                ssqj =
                    sjij + (Array.get (j - 1) rest.previousMatrix |> Maybe.withDefault 0)

                previousMatrixValue =
                    Array.get (lowIndex - 1) rest.previousMatrix |> Maybe.withDefault 0

                sjLowi =
                    ssq lowIndex i rest.sums rest.sumsOfSquares

                ssqjLow =
                    sjLowi + previousMatrixValue

                ( tmpM, tmpBm ) =
                    if ssqjLow < m then
                        ( ssqjLow, lowIndex )

                    else
                        ( m, bm )

                ( newM, newBm ) =
                    if ssqj < tmpM then
                        ( ssqj, j )

                    else
                        ( tmpM, tmpBm )
            in
            if (sjij + previousMatrixValue) >= m then
                ( True, m, bm )

            else
                ( False, newM, newBm )

        values =
            getValues low high

        ( _, outM, outBm ) =
            List.foldl calcMatrixAndBacktrackMatrix ( False, startValue, i ) values
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
