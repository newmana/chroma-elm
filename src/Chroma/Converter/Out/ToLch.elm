module Chroma.Converter.Out.ToLch exposing (toLch, toLchExt)

{-| Convert ExtColor to LCH


# Definition

@docs toLch, toLchExt

-}

import Chroma.Converter.In.Lab2Lch as Lab2Lch
import Chroma.Converter.Out.ToLab as ToLab
import Chroma.Types as Types


{-| TBD
-}
toLch : Types.ExtColor -> Types.LchColor
toLch color =
    ToLab.toLab color |> Lab2Lch.lab2lch


{-| TBD
-}
toLchExt : Types.ExtColor -> Types.ExtColor
toLchExt color =
    toLch color |> Types.LCHColor
