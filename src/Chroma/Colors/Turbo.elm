module Chroma.Colors.Turbo exposing (getColor)

{-| [Turbo](https://ai.googleblog.com/2019/08/turbo-improved-rainbow-colormap-for.html)

A colormap that has the desirable properties of Jet while also addressing some of its shortcomings, such as
false detail, banding and color blindness ambiguity.


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
            max 0 (min 255 (round (34.61 + boundedT * (1172.33 - boundedT * (10793.56 - boundedT * (33300.12 - boundedT * (38394.49 - boundedT * 14825.05)))))))

        g =
            max 0 (min 255 (round (23.31 + boundedT * (557.33 + boundedT * (1225.33 - boundedT * (3574.96 - boundedT * (1073.77 + boundedT * 707.56)))))))

        b =
            max 0 (min 255 (round (27.2 + boundedT * (3211.1 - boundedT * (15327.97 - boundedT * (27814 - boundedT * (22569.18 - boundedT * 6838.66)))))))
    in
    rgb255 r g b
