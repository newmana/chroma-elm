module Page.Chroma exposing (content)

import Chroma.Blend as Blend
import Chroma.Chroma as Chroma
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Limits.Limits as Limits
import Chroma.Types as Types
import Html as Html
import Html.Attributes as HtmlAttributes
import List.Nonempty as Nonempty
import Page.Page as Page


content : List (Html.Html msg)
content =
    [ Html.div
        [ HtmlAttributes.class "column"
        , HtmlAttributes.class "is-four-fifths"
        ]
        ([ Html.h1
            [ HtmlAttributes.class "title" ]
            [ Html.text "Chroma" ]
         , Html.p
            [ HtmlAttributes.class "subtitle" ]
            [ Html.text "Chroma.chroma(colorName : String)" ]
         ]
            ++ Page.p
                ("Given a string that represents either a W3CX11 color name or a 3, 6 or 8 hex string. "
                    ++ "The \"chroma\" function returns a Result either indicating an error or success. "
                )
            ++ Page.example "has-text-white" namedColorCode namedColorSourceCode namedColorOutput
            ++ Page.p "If the \"#\" is missing and it's not a valid color string it tries to parse it as a hex string."
            ++ Page.example "has-text-black" sixHexColorCode sixHexColorSourceCode sixHexColorOutput
            ++ Page.example "has-text-white" threeHexCode threeHexSourceCode threeHexOutput
            ++ Page.p "An 8 digit hex string defines that alpha channel (0-255 maps to 0-1)."
            ++ Page.example "has-text-black" eightHexCode eightHexSourceCode eightHexOutput
            ++ Page.p "If it fails to parse either as a valid color or hex string you must have a default color."
            ++ Page.example "has-text-white" unknownStringCode unknownStringSourceCode unknownStringOutput
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Chroma.mix(mode : Mode, ratio : Float, color1 : ExtColor, color2 : ExtColor)" ]
               ]
            ++ Page.example "has-text-white" mixCode mixSourceCode mixOutput
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Chroma.average(mode : Mode, colors : NonEmpty ExtColor)" ]
               ]
            ++ Page.example "has-text-white" averageCode averageSourceCode averageOutput
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Chroma.blend(mode : Mode, color1 : ExtColor, color2 : ExtColor)" ]
               ]
            ++ Page.example "has-text-white" blendCode blendSourceCode blendOutput
            ++ Page.example "has-text-black" blendChromaCode blendChromaSourceCode blendChromaOutput
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Chroma.contrast(color1 : ExtColor, color2 : ExtColor)" ]
               ]
            ++ Page.withinP
                [ Html.text "A minimum contrast ratio of 3:1 with 4.5:1 recommended by "
                , Html.a [ HtmlAttributes.href "https://www.w3.org/TR/WCAG20-TECHS/" ] [ Html.text "Web Content Accessibility Guidelines" ]
                , Html.text "."
                ]
            ++ Page.example "has-text-black" "" constrastSourceCode constrastOutput
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Chroma.distance(mode : Mode, color1 : ExtColor, color2 : ExtColor)" ]
               ]
            ++ Page.example "has-text-black" "" distanceRgbSourceCode distanceRgbOutput
            ++ Page.example "has-text-black" "" distanceLabSourceCode distanceLabOutput
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Chroma.limits(mode : LimitMode, bins, data)" ]
               ]
            ++ Page.p
                ("Sample data: "
                    ++ nonEmptyFloat sampleData
                    ++ ". "
                    ++ "LimitMode can be: CkMeans, Equal, HeadTail, Logarithmic or Quantial."
                )
            ++ Page.example "has-text-black" "" limitsCkMeansSourceCode limitsCkMeansOutput
            ++ Page.example "has-text-black" "" limitsHeadTailSourceCode limitsHeadTailOutput
            ++ Page.example "has-text-black" "" limitsEqualSourceCode limitsEqualOutput
        )
    ]


namedColorCode : String
namedColorCode =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> ToHex.toHex


namedColorSourceCode : String
namedColorSourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> ToHex.toHex  """


namedColorOutput : List (Html.Html msg)
namedColorOutput =
    [ Html.text
        """"#ff69b4" : String """
    ]


sixHexColorCode : String
sixHexColorCode =
    Chroma.chroma "3399ff" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> ToHex.toHex


sixHexColorSourceCode : String
sixHexColorSourceCode =
    """Chroma.chroma "3399ff"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> ToHex.toHex  """


sixHexColorOutput : List (Html.Html msg)
sixHexColorOutput =
    [ Html.text
        """"#3399ff" : String """
    ]


threeHexCode : String
threeHexCode =
    Chroma.chroma "#963" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> ToHex.toHex


threeHexSourceCode : String
threeHexSourceCode =
    """Chroma.chroma "#963"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> ToHex.toHex  """


threeHexOutput : List (Html.Html msg)
threeHexOutput =
    [ Html.text
        """"#996633" : String """
    ]


eightHexCode : String
eightHexCode =
    Chroma.chroma "#3399ff33" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> ToHex.toHexAlpha


eightHexSourceCode : String
eightHexSourceCode =
    """Chroma.chroma "#3399ff33"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> ToHex.toHexAlpha  """


eightHexOutput : List (Html.Html msg)
eightHexOutput =
    [ Html.text
        """"#3399ff33" : String """
    ]


unknownStringCode : String
unknownStringCode =
    Chroma.chroma "hello world" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> ToHex.toHexAlpha


unknownStringSourceCode : String
unknownStringSourceCode =
    """Chroma.chroma "hello world"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> ToHex.toHexAlpha  """


unknownStringOutput : List (Html.Html msg)
unknownStringOutput =
    [ Html.text
        """"#000000" : String """
    ]


mixCode : String
mixCode =
    Chroma.mix Types.RGBA 0.75 (Types.RGBAColor W3CX11.lightyellow) (Types.RGBAColor W3CX11.darkred)
        |> ToHex.toHexAlpha


mixSourceCode : String
mixSourceCode =
    """Chroma.mix Types.RGBA 0.75 (Types.RGBAColor W3CX11.lightyellow) (Types.RGBAColor W3CX11.darkred)
 |> ToHex.toHexAlpha """


mixOutput : List (Html.Html msg)
mixOutput =
    [ Html.text
        """"#a84038" : String """
    ]


averageCode : String
averageCode =
    Nonempty.Nonempty (Types.RGBAColor W3CX11.grey) [ Types.RGBAColor W3CX11.yellow, Types.RGBAColor W3CX11.red, Types.RGBAColor W3CX11.teal ]
        |> Chroma.average Types.LAB
        |> Result.withDefault (Types.RGBAColor W3CX11.black)
        |> ToHex.toHexAlpha


averageSourceCode : String
averageSourceCode =
    """Nonempty.Nonempty (Types.RGBAColor W3CX11.grey) [ Types.RGBAColor W3CX11.yellow, Types.RGBAColor W3CX11.red, Types.RGBAColor W3CX11.teal ]
 |> Chroma.average Types.LAB
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> ToHex.toHexAlpha  """


averageOutput : List (Html.Html msg)
averageOutput =
    [ Html.text
        """"#ba9254" : String """
    ]


blendCode : String
blendCode =
    Chroma.blend Blend.Burn (Types.RGBAColor W3CX11.lightyellow) (Types.RGBAColor W3CX11.darkred)
        |> ToHex.toHexAlpha


blendSourceCode : String
blendSourceCode =
    """Chroma.blend Blend.Burn (Types.RGBAColor W3CX11.lightyellow) (Types.RGBAColor W3CX11.darkred)
 |> ToHex.toHexAlpha """


blendOutput : List (Html.Html msg)
blendOutput =
    [ Html.text
        """"#a84038" : String """
    ]


blendChromaCode : String
blendChromaCode =
    Chroma.blendChroma Blend.Dodge "lightyellow" "darkred"
        |> Result.withDefault (Types.RGBAColor W3CX11.black)
        |> ToHex.toHexAlpha


blendChromaSourceCode : String
blendChromaSourceCode =
    """Chroma.blendChroma Blend.Dodge "lightyellow" "darkred"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> ToHex.toHexAlpha """


blendChromaOutput : List (Html.Html msg)
blendChromaOutput =
    [ Html.text
        """Ok "#ffff00ff" : Result String String """
    ]


constrastCode : String
constrastCode =
    Chroma.contrast (Types.RGBAColor W3CX11.pink) (Types.RGBAColor W3CX11.purple) |> String.fromFloat


constrastSourceCode : String
constrastSourceCode =
    """Chroma.contrast (Types.RGBAColor W3CX11.pink) (Types.RGBAColor W3CX11.purple)"""


constrastOutput : List (Html.Html msg)
constrastOutput =
    [ Html.text
        (constrastCode ++ " : Float")
    ]


distanceRgbCode : String
distanceRgbCode =
    Chroma.distance Types.RGBA (Types.RGBAColor W3CX11.black) (Types.RGBAColor W3CX11.purple) |> String.fromFloat


distanceRgbSourceCode : String
distanceRgbSourceCode =
    """Chroma.distance Types.RGBA (Types.RGBAColor W3CX11.black) (Types.RGBAColor W3CX11.purple)"""


distanceRgbOutput : List (Html.Html msg)
distanceRgbOutput =
    [ Html.text (distanceRgbCode ++ " : Float")
    ]


distanceLabCode : String
distanceLabCode =
    Chroma.distance Types.LAB (Types.RGBAColor W3CX11.black) (Types.RGBAColor W3CX11.purple) |> String.fromFloat


distanceLabSourceCode : String
distanceLabSourceCode =
    """Chroma.distance Types.LAB (Types.RGBAColor W3CX11.black) (Types.RGBAColor W3CX11.purple)"""


distanceLabOutput : List (Html.Html msg)
distanceLabOutput =
    [ Html.text (distanceLabCode ++ " : Float")
    ]


sampleData : Nonempty.Nonempty Float
sampleData =
    Nonempty.Nonempty 1 [ 2, 3, 4, 5, 6, 7, 8, 9, 10, 12 ]


nonEmptyFloat : Nonempty.Nonempty Float -> String
nonEmptyFloat a =
    "Nonempty " ++ (Nonempty.head a |> String.fromFloat) ++ " [" ++ (List.map String.fromFloat (Nonempty.tail a) |> String.join ", ") ++ "]"


limitsEqualCode : String
limitsEqualCode =
    Chroma.limits Limits.Equal 4 sampleData |> nonEmptyFloat


limitsEqualSourceCode : String
limitsEqualSourceCode =
    """Chroma.limits Limits.Equal 4 sampleData"""


limitsEqualOutput : List (Html.Html msg)
limitsEqualOutput =
    [ Html.text limitsEqualCode
    ]


limitsCkMeansCode : String
limitsCkMeansCode =
    Chroma.limits Limits.CkMeans 4 sampleData |> nonEmptyFloat


limitsCkMeansSourceCode : String
limitsCkMeansSourceCode =
    """Chroma.limits Limits.CkMeans 4 sampleData"""


limitsCkMeansOutput : List (Html.Html msg)
limitsCkMeansOutput =
    [ Html.text limitsCkMeansCode
    ]


limitsHeadTailCode : String
limitsHeadTailCode =
    Chroma.limits Limits.HeadTail 4 sampleData |> nonEmptyFloat


limitsHeadTailSourceCode : String
limitsHeadTailSourceCode =
    """Chroma.limits Limits.HeadTail 4 sampleData"""


limitsHeadTailOutput : List (Html.Html msg)
limitsHeadTailOutput =
    [ Html.text limitsHeadTailCode
    ]
