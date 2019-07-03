module Page.GettingStarted exposing (content)

import Chroma.Chroma as Chroma
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Out.ToHex as OutHex
import Chroma.Ops.Lightness as OpsLightness
import Chroma.Ops.Saturate as OpsSaturate
import Chroma.Types as Types
import Html as Html
import Html.Attributes as HtmlAttributes


content : List (Html.Html msg)
content =
    [ Html.div
        [ HtmlAttributes.class "column"
        ]
        [ Html.h1
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
        , Html.p
            []
            [ Html.text "For example:" ]
        , Html.div
            [ HtmlAttributes.class "container"
            ]
            [ Html.div
                [ HtmlAttributes.class "columns"
                ]
                [ Html.div
                    [ HtmlAttributes.class "column"
                    , HtmlAttributes.class "is-three-fifths"
                    ]
                    [ Html.div
                        [ HtmlAttributes.class "box"
                        ]
                        [ Html.pre
                            []
                            [ Html.code
                                []
                                [ Html.text example1SourceCode
                                ]
                            ]
                        ]
                    ]
                , Html.div
                    [ HtmlAttributes.class "column"
                    , HtmlAttributes.class "is-two-fifths"
                    ]
                    [ Html.div
                        [ HtmlAttributes.class "box"
                        , HtmlAttributes.class "is-shadowless"
                        ]
                        [ Html.pre
                            []
                            [ Html.code
                                [ HtmlAttributes.class "has-text-white"
                                , HtmlAttributes.style "background-color" example1Code
                                ]
                                [ Html.text example1Output
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
    ]


example1Code : String
example1Code =
    Chroma.chroma "pink" |> Result.withDefault (Types.RGBColor W3CX11.black) |> OpsLightness.darken 1 |> OpsSaturate.saturate 2 |> OutHex.toHex


example1SourceCode : String
example1SourceCode =
    """Chroma.chroma "pink"
 |> Result.withDefault (Types.RGBColor W3CX11.black)
 |> OpsLightness.darken 1 |> OpsSaturate.saturate 2
 |> OutHex.toHex  """


example1Output : String
example1Output =
    """"#ff6d93" : String """
