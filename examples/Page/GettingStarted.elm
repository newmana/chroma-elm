module Page.GettingStarted exposing (content)

import Chroma.Chroma as Chroma
import Chroma.Colors.Cmocean as Cmocean
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Converter.Out.ToLch as ToLch
import Chroma.Limits.Limits as Limits
import Chroma.Ops.Lightness as OpsLightness
import Chroma.Ops.Saturate as OpsSaturate
import Chroma.Scale as Scale
import Chroma.Types as Types
import Color as Color
import Html as Html
import Html.Attributes as HtmlAttributes
import Legend as Legend
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
            [ Html.text "Getting Started" ]
         , Html.p
            [ HtmlAttributes.class "subtitle" ]
            [ Html.text "A native Elm version of the "
            , Html.a [ HtmlAttributes.href "https://vis4.net/chromajs" ] [ Html.text "chroma.js" ]
            , Html.text " library."
            ]
         , Html.div
            [ HtmlAttributes.class "content" ]
            [ Html.p
                []
                [ Html.text "The features include:" ]
            , Html.ul
                []
                [ Html.li
                    []
                    [ Html.text "Allowing the use of W3C X11 color names and creating color scales."
                    ]
                , Html.li
                    []
                    [ Html.text "Clustering data points using algorithms: CkMeans, equal, head/tail, Jenks, logarithmic or quantile."
                    ]
                , Html.li
                    []
                    [ Html.text "Color maps including: Brewer, cmocean, Material, Cividis, Turbo, Sinebow, Parula, Virdis, Plasma, Magma and Inferno."
                    ]
                , Html.li
                    []
                    [ Html.text "Color space support including: CMYK, HSLA, LAB, LCH and RGB."
                    ]
                , Html.li
                    []
                    [ Html.text "Color operations: interpolate, get/set alpha, lighten/darken, saturate/desaturate."
                    ]
                ]
            ]
         ]
            ++ parsingString
            ++ discreteColormap
            ++ continuousColormap
        )
    ]


parsingString : List (Html.Html msg)
parsingString =
    Page.example "has-text-white" parsingStringCode parsingStringSourceCode parsingStringOutput


parsingStringCode : String
parsingStringCode =
    Chroma.chroma "pink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsLightness.darken 1 |> OpsSaturate.saturate 2 |> ToHex.toHex


parsingStringSourceCode : String
parsingStringSourceCode =
    """Chroma.chroma "pink"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsLightness.darken 1 |> OpsSaturate.saturate 2
 |> ToHex.toHex  """


parsingStringOutput : List (Html.Html msg)
parsingStringOutput =
    [ Html.text """"#ff6d93" : String """ ]


discreteColormap : List (Html.Html msg)
discreteColormap =
    Page.p
        "It can be used to generate color maps. "
        ++ Page.example "has-text-black" "#f5f5f5" discreteColormapSourceCode discreteColormapOutput


discreteColormapCode : Nonempty.Nonempty Types.ExtColor
discreteColormapCode =
    Nonempty.Nonempty (Color.rgb255 250 250 110) [ Color.rgb255 42 72 88 ] |> Nonempty.map (Types.RGBAColor >> ToLch.toLchExt) |> Chroma.colors 6 |> Tuple.second


discreteColormapSourceCode : String
discreteColormapSourceCode =
    """Nonempty.Nonempty (rgb255 250 250 110) [ rgb255 42 72 88 ]
 |> Nonempty.map (Types.RGBAColor >> ToLch.toLchExt)
 |> Chroma.colors 6"""


discreteColormapOutput : List (Html.Html msg)
discreteColormapOutput =
    let
        createHtml extColor =
            Html.span
                [ HtmlAttributes.style "background-color" (ToHex.toHex extColor)
                ]
                [ Html.text "\u{00A0}\u{00A0}\u{00A0}"
                ]

        textWith str =
            Html.span
                []
                [ Html.text str
                ]

        colorsWithCommas =
            Nonempty.map createHtml discreteColormapCode |> Nonempty.toList |> List.intersperse (textWith ",")
    in
    [ textWith "[" ] ++ colorsWithCommas ++ [ textWith "]" ]


continuousColormap : List (Html.Html msg)
continuousColormap =
    let
        data =
            "Nonempty.Nonempty "
                ++ String.fromFloat (Nonempty.head julyMaximums)
                ++ " ["
                ++ (List.map String.fromFloat (Nonempty.tail julyMaximums) |> List.intersperse ", " |> List.foldl (++) "")
                ++ " ]"

        code =
            "julyMaximums = "
                ++ data
                ++ "\n"
                ++ "ticks = Chroma.limits Limits.CkMeans 4 julyMaximums\n"
                ++ "colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Cmocean.matter)"
    in
    Page.p
        "Or to generate evenly distributed buckets across a continuous color map."
        ++ Page.example "has-text-black" "#f5f5f5" code [ Legend.view config ]


config : Legend.ContinuousLegendConfig
config =
    { ticks = Chroma.limits Limits.CkMeans 4 julyMaximums
    , colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Cmocean.matter)
    }


julyMaximums : Nonempty.Nonempty Float
julyMaximums =
    Nonempty.Nonempty 24.7 [ 25.2, 25.0, 24.3, 21.9, 22.0, 22.8, 19.7, 24.1, 23.8, 25.2, 26.2, 24.1, 20.3, 19.9, 23.3, 23.2, 24.6, 22.9, 22.6, 23.3, 24.7, 27.3, 27.1, 24.9, 23.5, 27.2, 25.3, 25.0, 26.1, 23.0 ]
