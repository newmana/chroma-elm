module Chroma.Colors.Cividis exposing (getColor)

{-| [Cividis](https://github.com/marcosci/cividis)

Enables nearly-identical visual-data interpretation to color vision deficiency (CVD) people. It is perceptually
uniform in hue and brightness, and increases in brightness linearly.


# Color Scale

@docs getColor

-}

import Color exposing (Color, rgb255)


{-| TBD
-}
getColor : Float -> Color
getColor t =
    let
        boundedT =
            clamp 0 1 t

        r =
            max 0 (min 255 (round (-4.54 - boundedT * (35.34 - boundedT * (2381.73 - boundedT * (6402.7 - boundedT * (7024.72 - boundedT * 2710.57)))))))

        g =
            max 0 (min 255 (round (32.49 + boundedT * (170.73 + boundedT * (52.82 - boundedT * (131.46 - boundedT * (176.58 - boundedT * 67.37)))))))

        b =
            max 0 (min 255 (round (81.24 + boundedT * (442.36 - boundedT * (2482.43 - boundedT * (6167.24 - boundedT * (6614.94 - boundedT * 2475.67)))))))
    in
    rgb255 r g b
