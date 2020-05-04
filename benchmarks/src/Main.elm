module Main exposing (main)

import Benchmark as Benchmark
import Benchmark.Runner as BenchmarkRunner
import Chroma.Chroma as Chroma
import Chroma.Limits.Limits as Limits
import List.Nonempty as Nonempty


suite : Benchmark.Benchmark
suite =
    let
        testData =
            Nonempty.Nonempty 1 (List.repeat 10 [ -1, 2, -1, 2, 4, 5, 6, -1, 2, -1 ] |> List.concat)
        testDataSize =
             (Nonempty.length testData) |> String.fromInt
    in
    Benchmark.describe "Limits (Class Breaks)"
        [ Benchmark.benchmark ("CkMeans 4 Classes, " ++ testDataSize ++ " data points") <| \_ -> Chroma.limits Limits.CkMeans 4 testData
        [ Benchmark.benchmark ("Jenks 4 Classes, " ++ testDataSize ++ " data points") <| \_ -> Chroma.limits Limits.Jenks 4 testData
        , Benchmark.benchmark ("Equal 4 Classes, " ++ testDataSize ++ " data points") <| \_ -> Chroma.limits Limits.Equal 4 testData
        , Benchmark.benchmark ("HeadTail 4 Classes, " ++ testDataSize ++ " data points") <| \_ -> Chroma.limits Limits.HeadTail 4 testData
        , Benchmark.benchmark ("Logarithmic 4 Classes, " ++ testDataSize ++ " data points") <| \_ -> Chroma.limits Limits.Logarithmic 4 testData
        , Benchmark.benchmark ("Quantile 4 Classes, " ++ testDataSize ++ " data points") <| \_ -> Chroma.limits Limits.Quantile 4 testData
        ]


main : BenchmarkRunner.BenchmarkProgram
main =
    BenchmarkRunner.program suite
