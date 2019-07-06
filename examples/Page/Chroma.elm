module Page.Chroma exposing (content)

import Chroma.Chroma as Chroma
import Chroma.Colors.W3CX11 as W3CX11
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
            [ Html.text "Chroma" ]
         , Html.p
            [ HtmlAttributes.class "subtitle" ]
            [ Html.text "Chroma.chroma(string)" ]
         ]
            ++ Page.p
                ("Given a string that represents either a W3CX11 color name or a 3, 6 or 8 hex string. "
                    ++ "The \"chroma\" function returns a Result either indicating an error or success. "
                )
            ++ Page.example example1Code example1SourceCode example1Output "has-text-white"
            ++ Page.p "If the \"#\" is missing and it's not a valid color string it tries to parse it as a hex string."
            ++ Page.example example2Code example2SourceCode example2Output "has-text-black"
            ++ Page.example example3Code example3SourceCode example3Output "has-text-white"
            ++ Page.p "An 8 digit hex string defines that alpha channel (0-255 maps to 0-1)."
            ++ Page.example example4Code example4SourceCode example4Output "has-text-black"
            ++ Page.p "If it fails to parse either as a valid color or hex string you must have a default color."
            ++ Page.example example5Code example5SourceCode example5Output "has-text-white"
            ++ Page.p "Other color spaces can be used to as well."
            ++ Page.example example6Code example6SourceCode example6Output "has-text-black"
            ++ Page.example example7Code example7SourceCode example7Output "has-text-black"
            ++ Page.example example8Code example8SourceCode example8Output "has-text-white"
        )
    ]


example1Code : String
example1Code =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBColor W3CX11.black) |> ToHex.toHex


example1SourceCode : String
example1SourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBColor W3CX11.black)
 |> ToHex.toHex  """


example1Output : List (Html.Html msg)
example1Output =
    [ Html.text
        """"#ff69b4" : String """
    ]


example2Code : String
example2Code =
    Chroma.chroma "3399ff" |> Result.withDefault (Types.RGBColor W3CX11.black) |> ToHex.toHex


example2SourceCode : String
example2SourceCode =
    """Chroma.chroma "3399ff"
 |> Result.withDefault (Types.RGBColor W3CX11.black)
 |> ToHex.toHex  """


example2Output : List (Html.Html msg)
example2Output =
    [ Html.text
        """"#3399ff" : String """
    ]


example3Code : String
example3Code =
    Chroma.chroma "#963" |> Result.withDefault (Types.RGBColor W3CX11.black) |> ToHex.toHex


example3SourceCode : String
example3SourceCode =
    """Chroma.chroma "#963"
 |> Result.withDefault (Types.RGBColor W3CX11.black)
 |> ToHex.toHex  """


example3Output : List (Html.Html msg)
example3Output =
    [ Html.text
        """"#996633" : String """
    ]


example4Code : String
example4Code =
    Chroma.chroma "#3399ff33" |> Result.withDefault (Types.RGBColor W3CX11.black) |> ToHex.toHexAlpha


example4SourceCode : String
example4SourceCode =
    """Chroma.chroma "#3399ff33"
 |> Result.withDefault (Types.RGBColor W3CX11.black)
 |> ToHex.toHexAlpha  """


example4Output : List (Html.Html msg)
example4Output =
    [ Html.text
        """"#3399ff33" : String """
    ]


example5Code : String
example5Code =
    Chroma.chroma "hello world" |> Result.withDefault (Types.RGBColor W3CX11.black) |> ToHex.toHexAlpha


example5SourceCode : String
example5SourceCode =
    """Chroma.chroma "hello world"
 |> Result.withDefault (Types.RGBColor W3CX11.black)
 |> ToHex.toHexAlpha  """


example5Output : List (Html.Html msg)
example5Output =
    [ Html.text
        """"#000000" : String """
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
