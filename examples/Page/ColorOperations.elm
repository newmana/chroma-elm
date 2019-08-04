module Page.ColorOperations exposing (content)

import Chroma.Chroma as Chroma
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Ops.Alpha as OpsAlpha
import Chroma.Ops.Lightness as OpsLightness
import Chroma.Ops.Saturate as OpsSaturate
import Chroma.Types as Types
import Color as Color
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
            [ Html.text "Color Operations" ]
         , Html.p
            [ HtmlAttributes.class "subtitle" ]
            [ Html.text "Functions to modify an existing color value" ]
         ]
            ++ example1
            ++ example2
            ++ example3
            ++ example4
            ++ example5
            ++ example6
            ++ example7
            ++ example8
        )
    ]


example1 : List (Html.Html msg)
example1 =
    Page.example "has-text-white" example1Code example1SourceCode example1Output


example1Code : String
example1Code =
    Chroma.chroma "red" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsAlpha.setAlpha 0.5 |> ToHex.toHexAlpha


example1SourceCode : String
example1SourceCode =
    """Chroma.chroma "red"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsLightness.alpha 0.5
 |> ToHex.toHexAlpha  """


example1Output : List (Html.Html msg)
example1Output =
    [ Html.text ("\"" ++ example1Code ++ "\" : String ") ]


example2 : List (Html.Html msg)
example2 =
    Page.example "has-text-black" "" example2SourceCode example2Output


example2Code : String
example2Code =
    Types.RGBAColor (Color.rgba 1 0 0 0.35) |> OpsAlpha.alpha |> String.fromFloat


example2SourceCode : String
example2SourceCode =
    """Types.RGBAColor (Color.rgba 1 0 0 0.35)
 |> OpsAlpha.alpha """


example2Output : List (Html.Html msg)
example2Output =
    [ Html.text ("\"" ++ example2Code ++ "\" : Float ") ]


example3 : List (Html.Html msg)
example3 =
    Page.example "has-text-white" example3Code example3SourceCode example3Output


example3Code : String
example3Code =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsLightness.darken 1.0 |> ToHex.toHex


example3SourceCode : String
example3SourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsLightness.darken 1.0
 |> ToHex.toHex """


example3Output : List (Html.Html msg)
example3Output =
    [ Html.text """"#c93384" : String  """ ]


example4 : List (Html.Html msg)
example4 =
    Page.example "has-text-white" example4Code example4SourceCode example4Output


example4Code : String
example4Code =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsLightness.darken 2.0 |> ToHex.toHex


example4SourceCode : String
example4SourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsLightness.darken 2.0
 |> ToHex.toHex """


example4Output : List (Html.Html msg)
example4Output =
    [ Html.text """"#c930058" : String  """ ]


example5 : List (Html.Html msg)
example5 =
    Page.example "has-text-black" example5Code example5SourceCode example5Output


example5Code : String
example5Code =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsLightness.brighten 2.0 |> ToHex.toHex


example5SourceCode : String
example5SourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsLightness.brighten 2.0
 |> ToHex.toHex """


example5Output : List (Html.Html msg)
example5Output =
    [ Html.text """"#ffd1ff" : String  """ ]


example6 : List (Html.Html msg)
example6 =
    Page.example "has-text-black" example6Code example6SourceCode example6Output


example6Code : String
example6Code =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsLightness.brighten 3.0 |> ToHex.toHex


example6SourceCode : String
example6SourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsLightness.brighten 3.0
 |> ToHex.toHex """


example6Output : List (Html.Html msg)
example6Output =
    [ Html.text """"#ffffff" : String  """ ]


example7 : List (Html.Html msg)
example7 =
    Page.example "has-text-white" example7Code example7SourceCode example7Output


example7Code : String
example7Code =
    Chroma.chroma "slategray" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsSaturate.saturate 2.0 |> ToHex.toHex


example7SourceCode : String
example7SourceCode =
    """Chroma.chroma "slategray"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsSaturate.saturate 2.0
 |> ToHex.toHex """


example7Output : List (Html.Html msg)
example7Output =
    [ Html.text """"##0087cd" : String  """ ]


example8 : List (Html.Html msg)
example8 =
    Page.example "has-text-white" example8Code example8SourceCode example8Output


example8Code : String
example8Code =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsSaturate.desaturate 3.0 |> ToHex.toHex


example8SourceCode : String
example8SourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsSaturate.desaturate 3.0
 |> ToHex.toHex """


example8Output : List (Html.Html msg)
example8Output =
    [ Html.text """"##b199a3" : String  """ ]
