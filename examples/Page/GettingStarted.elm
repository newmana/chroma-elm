module Page.GettingStarted exposing (content)

import Chroma.Chroma as Chroma
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Converter.Out.ToLch as ToLch
import Chroma.Ops.Lightness as OpsLightness
import Chroma.Ops.Saturate as OpsSaturate
import Chroma.Types as Types
import Color as Color
import Html as Html
import Html.Attributes as HtmlAttributes
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
            [ Html.text "Chroma-elm is an Elm native version of the chroma.js library." ]
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
                    [ Html.text "Color space support including: CMYK, HSL, LAB, LCH and RGB."
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
        )
    ]


example1 : List (Html.Html msg)
example1 =
    Page.example example1Code example1SourceCode example1Output "has-text-white"


example1Code : String
example1Code =
    Chroma.chroma "pink" |> Result.withDefault (Types.RGBColor W3CX11.black) |> OpsLightness.darken 1 |> OpsSaturate.saturate 2 |> ToHex.toHex


example1SourceCode : String
example1SourceCode =
    """Chroma.chroma "pink"
 |> Result.withDefault (Types.RGBColor W3CX11.black)
 |> OpsLightness.darken 1 |> OpsSaturate.saturate 2
 |> ToHex.toHex  """


example1Output : List (Html.Html msg)
example1Output =
    [ Html.text """"#ff6d93" : String """ ]


example2 : List (Html.Html msg)
example2 =
    Page.p
        "It can also be used to generate colormaps. "
        ++ Page.example "#f5f5f5" example2SourceCode example2Output "has-text-black"


example2Code : Nonempty.Nonempty Types.ExtColor
example2Code =
    Nonempty.Nonempty (Color.rgb255 250 250 110) [ Color.rgb255 42 72 88 ] |> Nonempty.map ToLch.toLchExtColor |> Chroma.colors 6 |> Tuple.second


example2SourceCode : String
example2SourceCode =
    """Nonempty.Nonempty (rgb255 250 250 110) [ rgb255 42 72 88 ]
 |> Nonempty.map ToLch.toLchExtColor
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
