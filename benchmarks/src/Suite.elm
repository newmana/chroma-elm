module Suite exposing (main)

import Benchmark as Benchmark
import Benchmark.Runner as BenchmarkRunner
import Chroma.Chroma as Chroma
import Chroma.Limits.Limits as Limits
import List.Nonempty as Nonempty


suite : Benchmark.Benchmark
suite =
    let
        testData =
            Nonempty.Nonempty 1 (List.repeat 20 [ -1, 2, -1, 2, 4, 5, 6, -1, 2, -1 ] |> List.concat)
    in
    Benchmark.describe "detectFrequency"
        [ Benchmark.benchmark "1001" <| \_ -> Chroma.limits testData Limits.CkMeans 4
        ]


main : BenchmarkRunner.BenchmarkProgram
main =
    BenchmarkRunner.program suite
