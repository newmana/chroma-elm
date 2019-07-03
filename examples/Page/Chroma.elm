module Page.Chroma exposing (content)

import Chroma.Chroma as Chroma
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Types as Types
import Html as Html
import Html.Attributes as HtmlAttributes


content : List (Html.Html msg)
content =
    [ Html.div
        [ HtmlAttributes.class "column"
        ]
        ([ Html.h1
            [ HtmlAttributes.class "title" ]
            [ Html.text "Chroma" ]
         , Html.p
            [ HtmlAttributes.class "subtitle" ]
            [ Html.text "Chroma.chroma(string)" ]
         , Html.div
            [ HtmlAttributes.class "content" ]
            [ Html.p
                []
                [ Html.text "Given a string that represents either a W3CX11 color name or a 3, 6 or 8 hex string." ]
            ]
         ]
            ++ example example1Code example1SourceCode example1Output "has-text-white"
            ++ example example2Code example2SourceCode example2Output "has-text-white"
            ++ example example3Code example3SourceCode example3Output "has-text-black"
            ++ example example4Code example4SourceCode example4Output "has-text-black"
        )
    ]


example : String -> String -> String -> String -> List (Html.Html msg)
example code source output textColor =
    [ Html.div
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
                            [ Html.text source
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
                            [ HtmlAttributes.class textColor
                            , HtmlAttributes.style "background-color" code
                            ]
                            [ Html.text output
                            ]
                        ]
                    ]
                ]
            ]
        ]
    ]


example1Code : String
example1Code =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBColor W3CX11.black) |> ToHex.toHex


example1SourceCode : String
example1SourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBColor W3CX11.black)
 |> ToHex.toHex  """


example1Output : String
example1Output =
    """"#ff69b4" : String """


example2Code : String
example2Code =
    Chroma.chroma "#963" |> Result.withDefault (Types.RGBColor W3CX11.black) |> ToHex.toHex


example2SourceCode : String
example2SourceCode =
    """Chroma.chroma "#963"
 |> Result.withDefault (Types.RGBColor W3CX11.black)
 |> ToHex.toHex  """


example2Output : String
example2Output =
    """"#996633" : String """


example3Code : String
example3Code =
    Chroma.chroma "#3399ff" |> Result.withDefault (Types.RGBColor W3CX11.black) |> ToHex.toHex


example3SourceCode : String
example3SourceCode =
    """Chroma.chroma "#3399ff"
 |> Result.withDefault (Types.RGBColor W3CX11.black)
 |> ToHex.toHex  """


example3Output : String
example3Output =
    """"#3399ff" : String """


example4Code : String
example4Code =
    Chroma.chroma "#3399ff33" |> Result.withDefault (Types.RGBColor W3CX11.black) |> ToHex.toHexAlpha


example4SourceCode : String
example4SourceCode =
    """Chroma.chroma "#3399ff33"
 |> Result.withDefault (Types.RGBColor W3CX11.black)
 |> ToHex.toHexAlpha  """


example4Output : String
example4Output =
    """"#3399ff33" : String """
