module Page.GettingStarted exposing (content)

import Chroma.Chroma as Chroma
import Chroma.Colors.Plasma as Plasma
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Converter.Out.ToLch as ToLch
import Chroma.Limits.Limits as Limits
import Chroma.Ops.Lightness as OpsLightness
import Chroma.Ops.Saturate as OpsSaturate
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
                    [ Html.text "Colormaps including: brewer, w3cx11, viridis, plasma, magma and inferno."
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
            ++ example1
            ++ example2
            ++ example3
        )
    ]


example1 : List (Html.Html msg)
example1 =
    Page.example "has-text-white" example1Code example1SourceCode example1Output


example1Code : String
example1Code =
    Chroma.chroma "pink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsLightness.darken 1 |> OpsSaturate.saturate 2 |> ToHex.toHex


example1SourceCode : String
example1SourceCode =
    """Chroma.chroma "pink"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsLightness.darken 1 |> OpsSaturate.saturate 2
 |> ToHex.toHex  """


example1Output : List (Html.Html msg)
example1Output =
    [ Html.text """"#ff6d93" : String """ ]


example2 : List (Html.Html msg)
example2 =
    Page.p
        "It can be used to generate colormaps. "
        ++ Page.example "has-text-black" "#f5f5f5" example2SourceCode example2Output


example2Code : Nonempty.Nonempty Types.ExtColor
example2Code =
    Nonempty.Nonempty (Color.rgb255 250 250 110) [ Color.rgb255 42 72 88 ] |> Nonempty.map (Types.RGBAColor >> ToLch.toLchExt) |> Chroma.colors 6 |> Tuple.second


example2SourceCode : String
example2SourceCode =
    """Nonempty.Nonempty (rgb255 250 250 110) [ rgb255 42 72 88 ]
 |> Nonempty.map (Types.RGBAColor >> ToLch.toLchExt)
 |> Chroma.colors 6 |> Tuple.second"""


example2Output : List (Html.Html msg)
example2Output =
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
            Nonempty.map createHtml example2Code |> Nonempty.toList |> List.intersperse (textWith ",")
    in
    [ textWith "[" ] ++ colorsWithCommas ++ [ textWith "]" ]


example3 : List (Html.Html msg)
example3 =
    let
        data =
            "Nonempty.Nonempty "
                ++ String.fromFloat (Nonempty.head julyMaximums)
                ++ " ["
                ++ (List.map String.fromFloat (Nonempty.tail julyMaximums) |> List.intersperse ", " |> List.foldl (++) "")
                ++ " ]"

        code =
            data ++ """
 |> (\\x -> Chroma.limits x Limits.CkMeans 4)"""
    in
    Page.p
        "Or to generate evenly distributed buckets across a continuous color map."
        ++ Page.example "has-text-black" "#f5f5f5" code [ Legend.view config ]


config : Legend.ContinuousLegendConfig
config =
    { ticks = julyMaximums |> (\x -> Chroma.limits x Limits.CkMeans 4)
    , colours = Nonempty.map Types.RGBAColor Plasma.plasma |> Nonempty.reverse
    }


julyMaximums : Nonempty.Nonempty Float
julyMaximums =
    Nonempty.Nonempty 24.7 [ 25.2, 25.0, 24.3, 21.9, 22.0, 22.8, 19.7, 24.1, 23.8, 25.2, 26.2, 24.1, 20.3, 19.9, 23.3, 23.2, 24.6, 22.9, 22.6, 23.3, 24.7, 27.3, 27.1, 24.9, 23.5, 27.2, 25.3, 25.0, 26.1, 23.0 ]
