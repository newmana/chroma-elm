module Chroma.Colors.W3CX11 exposing
    ( named, w3cx11
    , aliceBlue, antiqueWhite, aqua, azure, aquamarine
    , beige, bisque, black, blanchedalmond, blue, blueviolet, brown, burlywood, cadetblue
    , chocolate, coral, cornflowerblue, cornsilk, crimson, cyan, chartreuse
    , darkolivegreen, darkseagreen, darkslategrey, dimgray, darkslategray, dodgerblue, darkgrey, darkturquoise, darkgreen, darkviolet, darkgray, darkslateblue, deeppink, darkmagenta, darkgoldenrod, dimgrey, darkblue, darkkhaki, darkcyan, darkorchid, deepskyblue, darkred, darkorange, darksalmon
    , firebrick
    , gold
    , hotpink
    , indianred, indigo
    , red
    , lightgreen
    , white
    , yellow
    )

{-| All of the X11 color names <https://en.wikipedia.org/wiki/X11_color_names>


# Definition

@docs named, w3cx11


# Colours

@docs aliceBlue, antiqueWhite, aqua, azure, aquamarine
@docs beige, bisque, black, blanchedalmond, blue, blueviolet, brown, burlywood, cadetblue
@docs chocolate, coral, cornflowerblue, cornsilk, crimson, cyan, chartreuse
@docs darkolivegreen, darkseagreen, darkslategrey, dimgray, darkslategray, dodgerblue, darkgrey, darkturquoise, darkgreen, darkviolet, darkgray, darkslateblue, deeppink, darkmagenta, darkgoldenrod, dimgrey, darkblue, darkkhaki, darkcyan, darkorchid, deepskyblue, darkred, darkorange, darksalmon
@docs firebrick
@docs gold
@docs hotpink
@docs indianred, indigo
@docs red
@docs lightgreen
@docs white
@docs yellow

-}

import Color exposing (Color, rgb255)
import Dict
import Result


{-| Lookup a colour by name.

    named "red"
    --> Ok (RgbaSpace 1 0 0 1) : Result String Color.Color

-}
named : String -> Result String Color.Color
named str =
    Result.fromMaybe ("Cannot find " ++ str) (Dict.get str w3cx11)


{-| TBD
-}
aliceBlue : Color
aliceBlue =
    rgb255 240 248 255


{-| TBD
-}
antiqueWhite : Color
antiqueWhite =
    rgb255 250 235 215


{-| TBD
-}
aquamarine : Color
aquamarine =
    rgb255 127 255 212


{-| TBD
-}
aqua : Color
aqua =
    rgb255 0 255 255


{-| TBD
-}
azure : Color
azure =
    rgb255 240 255 255


{-| TBD
-}
beige : Color
beige =
    rgb255 245 245 220


{-| TBD
-}
bisque : Color
bisque =
    rgb255 255 228 196


{-| TBD
-}
black : Color
black =
    Color.black


{-| TBD
-}
blanchedalmond : Color
blanchedalmond =
    rgb255 255 235 205


{-| TBD
-}
blue : Color
blue =
    rgb255 0 0 255


{-| TBD
-}
blueviolet : Color
blueviolet =
    rgb255 138 43 226


{-| TBD
-}
brown : Color
brown =
    rgb255 165 42 42


{-| TBD
-}
burlywood : Color
burlywood =
    rgb255 222 184 135


{-| TBD
-}
cadetblue : Color
cadetblue =
    rgb255 95 158 160


{-| TBD
-}
chartreuse : Color
chartreuse =
    rgb255 127 255 0


{-| TBD
-}
chocolate : Color
chocolate =
    rgb255 210 105 30


{-| TBD
-}
coral : Color
coral =
    rgb255 255 127 80


{-| TBD
-}
cornflowerblue : Color
cornflowerblue =
    rgb255 100 149 237


{-| TBD
-}
crimson : Color
crimson =
    rgb255 220 20 60


{-| TBD
-}
cyan : Color
cyan =
    rgb255 0 255 255


{-| TBD
-}
cornsilk : Color
cornsilk =
    rgb255 255 248 220


{-| TBD
-}
darkolivegreen : Color
darkolivegreen =
    rgb255 85 107 47


{-| TBD
-}
darkseagreen : Color
darkseagreen =
    rgb255 143 188 143


{-| TBD
-}
darkslategrey : Color
darkslategrey =
    rgb255 47 79 79


{-| TBD
-}
dimgray : Color
dimgray =
    rgb255 105 105 105


{-| TBD
-}
darkslategray : Color
darkslategray =
    rgb255 47 79 79


{-| TBD
-}
dodgerblue : Color
dodgerblue =
    rgb255 30 144 255


{-| TBD
-}
darkgrey : Color
darkgrey =
    rgb255 169 169 169


{-| TBD
-}
darkturquoise : Color
darkturquoise =
    rgb255 0 206 209


{-| TBD
-}
darkgreen : Color
darkgreen =
    rgb255 0 100 0


{-| TBD
-}
darkviolet : Color
darkviolet =
    rgb255 148 0 211


{-| TBD
-}
darkgray : Color
darkgray =
    rgb255 169 169 169


{-| TBD
-}
darkslateblue : Color
darkslateblue =
    rgb255 47 79 79


{-| TBD
-}
deeppink : Color
deeppink =
    rgb255 255 20 147


{-| TBD
-}
darkmagenta : Color
darkmagenta =
    rgb255 139 0 139


{-| TBD
-}
darkgoldenrod : Color
darkgoldenrod =
    rgb255 184 134 11


{-| TBD
-}
dimgrey : Color
dimgrey =
    rgb255 105 105 105


{-| TBD
-}
darkblue : Color
darkblue =
    rgb255 0 0 139


{-| TBD
-}
darkkhaki : Color
darkkhaki =
    rgb255 189 183 107


{-| TBD
-}
darkcyan : Color
darkcyan =
    rgb255 0 139 139


{-| TBD
-}
darkorchid : Color
darkorchid =
    rgb255 153 50 204


{-| TBD
-}
deepskyblue : Color
deepskyblue =
    rgb255 0 191 255


{-| TBD
-}
darkred : Color
darkred =
    rgb255 139 0 0


{-| TBD
-}
darkorange : Color
darkorange =
    rgb255 255 140 0


{-| TBD
-}
darksalmon : Color
darksalmon =
    rgb255 233 150 122


{-| TBD
-}
firebrick : Color
firebrick =
    rgb255 178 34 34


{-| TBD
-}
gold : Color
gold =
    rgb255 255 215 0


{-| TBD
-}
hotpink : Color
hotpink =
    rgb255 255 105 180


{-| TBD
-}
indigo : Color
indigo =
    rgb255 75 0 130


{-| TBD
-}
indianred : Color
indianred =
    rgb255 205 92 92


{-| TBD
-}
lightgreen : Color
lightgreen =
    rgb255 144 238 144


{-| TBD
-}
red : Color
red =
    rgb255 255 0 0


{-| TBD
-}
yellow : Color
yellow =
    rgb255 255 255 0


{-| TBD
-}
white : Color
white =
    Color.white


{-| TBD
-}
w3cx11 : Dict.Dict String Color
w3cx11 =
    Dict.fromList
        [ ( "indigo", indigo )
        , ( "gold", gold )
        , ( "hotpink", hotpink )
        , ( "firebrick", firebrick )
        , ( "indianred", indianred )
        , ( "yellow", yellow )
        , ( "mistyrose", rgb255 255 228 225 )
        , ( "darkolivegreen", darkolivegreen )
        , ( "olive", rgb255 128 128 0 )
        , ( "darkseagreen", darkseagreen )
        , ( "pink", rgb255 255 192 203 )
        , ( "tomato", rgb255 255 99 71 )
        , ( "lightcoral", rgb255 240 128 128 )
        , ( "orangered", rgb255 255 69 0 )
        , ( "navajowhite", rgb255 255 222 173 )
        , ( "lime", rgb255 0 255 0 )
        , ( "palegreen", rgb255 152 251 152 )
        , ( "darkslategrey", darkslategrey )
        , ( "greenyellow", rgb255 173 255 47 )
        , ( "burlywood", burlywood )
        , ( "seashell", rgb255 255 245 238 )
        , ( "mediumspringgreen", rgb255 0 250 154 )
        , ( "fuchsia", rgb255 255 0 255 )
        , ( "papayawhip", rgb255 255 239 213 )
        , ( "blanchedalmond", blanchedalmond )
        , ( "chartreuse", chartreuse )
        , ( "dimgray", dimgray )
        , ( "black", black )
        , ( "peachpuff", rgb255 255 218 185 )
        , ( "springgreen", rgb255 0 255 127 )
        , ( "aquamarine", aquamarine )
        , ( "white", white )
        , ( "orange", rgb255 255 165 0 )
        , ( "lightsalmon", rgb255 255 160 122 )
        , ( "darkslategray", darkslategray )
        , ( "brown", brown )
        , ( "ivory", rgb255 255 255 240 )
        , ( "dodgerblue", dodgerblue )
        , ( "peru", rgb255 205 133 63 )
        , ( "lawngreen", rgb255 124 252 0 )
        , ( "chocolate", chocolate )
        , ( "crimson", crimson )
        , ( "forestgreen", rgb255 34 139 34 )
        , ( "darkgrey", darkgrey )
        , ( "lightseagreen", rgb255 32 178 170 )
        , ( "cyan", cyan )
        , ( "mintcream", rgb255 245 255 250 )
        , ( "silver", rgb255 192 192 192 )
        , ( "antiquewhite", antiqueWhite )
        , ( "mediumorchid", rgb255 186 85 211 )
        , ( "skyblue", rgb255 135 206 235 )
        , ( "gray", rgb255 128 128 128 )
        , ( "darkturquoise", darkturquoise )
        , ( "goldenrod", rgb255 218 165 32 )
        , ( "darkgreen", darkgreen )
        , ( "floralwhite", rgb255 255 250 240 )
        , ( "darkviolet", darkviolet )
        , ( "darkgray", darkgray )
        , ( "moccasin", rgb255 255 228 181 )
        , ( "saddlebrown", rgb255 139 69 19 )
        , ( "grey", rgb255 128 128 128 )
        , ( "darkslateblue", darkslateblue )
        , ( "lightskyblue", rgb255 135 206 250 )
        , ( "lightpink", rgb255 255 182 193 )
        , ( "mediumvioletred", rgb255 199 21 133 )
        , ( "slategrey", rgb255 112 128 144 )
        , ( "red", red )
        , ( "deeppink", deeppink )
        , ( "limegreen", rgb255 50 205 50 )
        , ( "darkmagenta", darkmagenta )
        , ( "palegoldenrod", rgb255 238 232 170 )
        , ( "plum", rgb255 221 160 221 )
        , ( "turquoise", rgb255 64 224 208 )
        , ( "lightgrey", rgb255 211 211 211 )
        , ( "lightgoldenrodyellow", rgb255 250 250 210 )
        , ( "darkgoldenrod", darkgoldenrod )
        , ( "lavender", rgb255 230 230 250 )
        , ( "maroon", rgb255 128 0 0 )
        , ( "yellowgreen", rgb255 154 205 50 )
        , ( "sandybrown", rgb255 244 164 96 )
        , ( "thistle", rgb255 216 191 216 )
        , ( "violet", rgb255 238 130 238 )
        , ( "navy", rgb255 0 0 128 )
        , ( "magenta", rgb255 255 0 255 )
        , ( "dimgrey", dimgrey )
        , ( "tan", rgb255 210 180 140 )
        , ( "rosybrown", rgb255 188 143 143 )
        , ( "olivedrab", rgb255 107 142 35 )
        , ( "blue", blue )
        , ( "lightblue", rgb255 173 216 230 )
        , ( "ghostwhite", rgb255 248 248 255 )
        , ( "honeydew", rgb255 240 255 240 )
        , ( "cornflowerblue", cornflowerblue )
        , ( "slateblue", rgb255 106 90 205 )
        , ( "linen", rgb255 250 240 230 )
        , ( "darkblue", darkblue )
        , ( "powderblue", rgb255 176 224 230 )
        , ( "seagreen", rgb255 46 139 87 )
        , ( "darkkhaki", darkkhaki )
        , ( "snow", rgb255 255 250 250 )
        , ( "sienna", rgb255 160 82 45 )
        , ( "mediumblue", rgb255 0 0 205 )
        , ( "royalblue", rgb255 65 105 225 )
        , ( "lightcyan", rgb255 224 255 255 )
        , ( "green", rgb255 0 128 0 )
        , ( "mediumpurple", rgb255 147 112 219 )
        , ( "midnightblue", rgb255 25 25 112 )
        , ( "cornsilk", cornsilk )
        , ( "paleturquoise", rgb255 175 238 238 )
        , ( "bisque", bisque )
        , ( "slategray", rgb255 112 128 144 )
        , ( "darkcyan", darkcyan )
        , ( "khaki", rgb255 240 230 140 )
        , ( "wheat", rgb255 245 222 179 )
        , ( "teal", rgb255 0 128 128 )
        , ( "darkorchid", darkorchid )
        , ( "deepskyblue", deepskyblue )
        , ( "salmon", rgb255 250 128 114 )
        , ( "darkred", darkred )
        , ( "steelblue", rgb255 70 130 180 )
        , ( "palevioletred", rgb255 219 112 147 )
        , ( "lightslategray", rgb255 119 136 153 )
        , ( "aliceblue", aliceBlue )
        , ( "lightslategrey", rgb255 119 136 153 )
        , ( "lightgreen", lightgreen )
        , ( "orchid", rgb255 218 112 214 )
        , ( "gainsboro", rgb255 220 220 220 )
        , ( "mediumseagreen", rgb255 60 179 113 )
        , ( "lightgray", rgb255 211 211 211 )
        , ( "mediumturquoise", rgb255 72 209 204 )
        , ( "lemonchiffon", rgb255 255 250 205 )
        , ( "cadetblue", cadetblue )
        , ( "lightyellow", rgb255 255 255 224 )
        , ( "lavenderblush", rgb255 255 240 245 )
        , ( "coral", coral )
        , ( "purple", rgb255 128 0 128 )
        , ( "aqua", aqua )
        , ( "whitesmoke", rgb255 245 245 245 )
        , ( "mediumslateblue", rgb255 123 104 238 )
        , ( "darkorange", darkorange )
        , ( "mediumaquamarine", rgb255 102 205 170 )
        , ( "darksalmon", darksalmon )
        , ( "beige", beige )
        , ( "blueviolet", blueviolet )
        , ( "azure", azure )
        , ( "lightsteelblue", rgb255 176 196 222 )
        , ( "oldlace", rgb255 253 245 230 )
        , ( "rebeccapurple", rgb255 102 51 153 )
        ]
