module Chroma.Converter.Out.ToLch exposing (toLch, toLchExtColor)

{-| Convert ExtColor to LCH


# Definition

@docs toLch, toLchExtColor

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


{-| TBD
-}
toLchExtColor : Color.Color -> Types.ExtColor
toLchExtColor color =
    toLch (Types.RGBColor color) |> Types.LCHColor
