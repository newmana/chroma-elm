module Page.Colors exposing (content)

import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Types as Types
import Html as Html
import Html.Attributes as HtmlAttributes
import Page.Page as Page


content : List (Html.Html msg)
content =
    [ Html.div
        [ HtmlAttributes.class "column"
        ]
        ([ Html.h1
            [ HtmlAttributes.class "title" ]
            [ Html.text "Colors" ]
         , Html.p
            [ HtmlAttributes.class "subtitle" ]
            [ Html.text "Creating Different Color Spaces" ]
         ]
            ++ Page.example "has-text-black" example1Code example1SourceCode example1Output
            ++ Page.example "has-text-black" example2Code example2SourceCode example2Output
            ++ Page.example "has-text-white" example3Code example3SourceCode example3Output
        )
    ]


example1Code : String
example1Code =
    { hueDegrees = 120.0, saturation = 1.0, lightness = 0.75, alpha = 1.0 } |> Types.HSLADegreesColor |> ToHex.toHex


example1SourceCode : String
example1SourceCode =
    """{ hueDegrees = 120.0, saturation = 1.0, lightness = 0.75, alpha = 1.0 }
 |> Types.HSLADegreesColor
 |> ToHex.toHex  """


example1Output : List (Html.Html msg)
example1Output =
    [ Html.text
        """"#80ff80" : String """
    ]


example2Code : String
example2Code =
    { luminance = 80.0, chroma = 25.0, hue = 200.0 } |> Types.LCHColor |> ToHex.toHex


example2SourceCode : String
example2SourceCode =
    """{ luminance = 80.0, chroma = 25.0, hue = 200.0 }
 |> Types.LCHColor
 |> ToHex.toHex  """


example2Output : List (Html.Html msg)
example2Output =
    [ Html.text
        """"#85d5d4" : String """
    ]


example3Code : String
example3Code =
    { cyan = 1.0, magenta = 0.5, yellow = 0.0, black = 0.2 } |> Types.CMYKColor |> ToHex.toHex


example3SourceCode : String
example3SourceCode =
    """{ cyan = 1.0, magenta = 0.5, yellow = 0.0, black = 0.2 }
 |> Types.CMYKColor
 |> ToHex.toHex  """


example3Output : List (Html.Html msg)
example3Output =
    [ Html.text
        """"#85d5d4" : String """
    ]
