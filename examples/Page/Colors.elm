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
            ++ Page.example example6Code example6SourceCode example6Output "has-text-black"
            ++ Page.example example7Code example7SourceCode example7Output "has-text-black"
            ++ Page.example example8Code example8SourceCode example8Output "has-text-white"
        )
    ]


example6Code : String
example6Code =
    { hueDegrees = 120.0, saturation = 1.0, lightness = 0.75, alpha = 1.0 } |> Types.HSLADegreesColor |> ToHex.toHex


example6SourceCode : String
example6SourceCode =
    """{ hueDegrees = 120.0, saturation = 1.0, lightness = 0.75, alpha = 1.0 }
 |> Types.HSLADegreesColor
 |> ToHex.toHex  """


example6Output : List (Html.Html msg)
example6Output =
    [ Html.text
        """"#80ff80" : String """
    ]


example7Code : String
example7Code =
    { luminance = 80.0, chroma = 25.0, hue = 200.0 } |> Types.LCHColor |> ToHex.toHex


example7SourceCode : String
example7SourceCode =
    """{ luminance = 80.0, chroma = 25.0, hue = 200.0 }
 |> Types.LCHColor
 |> ToHex.toHex  """


example7Output : List (Html.Html msg)
example7Output =
    [ Html.text
        """"#85d5d4" : String """
    ]


example8Code : String
example8Code =
    { cyan = 1.0, magenta = 0.5, yellow = 0.0, black = 0.2 } |> Types.CMYKColor |> ToHex.toHex


example8SourceCode : String
example8SourceCode =
    """{ cyan = 1.0, magenta = 0.5, yellow = 0.0, black = 0.2 }
 |> Types.CMYKColor
 |> ToHex.toHex  """


example8Output : List (Html.Html msg)
example8Output =
    [ Html.text
        """"#85d5d4" : String """
    ]
