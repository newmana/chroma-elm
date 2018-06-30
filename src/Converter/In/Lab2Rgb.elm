module Converter.In.Lab2Rgb
    exposing
        ( lab2rgb
        )

import Color as Color


lab2rgb : { lightness : Float, a : Float, b : Float } -> Color.Color
lab2rgb { lightness, a, b } =
    Color.rgb 0 0 0
