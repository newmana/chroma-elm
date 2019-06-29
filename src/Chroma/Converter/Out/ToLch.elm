module Chroma.Converter.Out.ToLch exposing (toLch)

{-| Convert ExtColor to LCH


# Definition

@docs toLch

-}

import Chroma.Converter.In.Lab2Lch as Lab2Lch
import Chroma.Converter.Out.ToLab as ToLab
import Chroma.Types as Types
import Color as Color


{-| TBD
-}
toLch : Types.ExtColor -> Types.LchColor
toLch color =
    ToLab.toLab color |> Lab2Lch.lab2lch
