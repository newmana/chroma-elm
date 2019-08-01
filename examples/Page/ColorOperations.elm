module Page.ColorOperations exposing (content)

import Chroma.Chroma as Chroma
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Ops.Alpha as OpsAlpha
import Chroma.Ops.Lightness as OpsLightness
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
        )
    ]


example1 : List (Html.Html msg)
example1 =
    Page.example example1Code example1SourceCode example1Output "has-text-white"


example1Code : String
example1Code =
    Chroma.chroma "red" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsAlpha.setAlpha 0.5 |> ToHex.toHexAlpha


example1SourceCode : String
example1SourceCode =
    """Chroma.chroma "red"
 |> Result.withDefault (Types.RGBColor W3CX11.black)
 |> OpsLightness.alpha 0.5
 |> ToHex.toHexAlpha  """


example1Output : List (Html.Html msg)
example1Output =
    [ Html.text """"#ff000080" : String """ ]


example2 : List (Html.Html msg)
example2 =
    Page.example example2Code example2SourceCode example2Output "has-text-black"


example2Code : String
example2Code =
    Types.RGBAColor (Color.rgba 1 0 0 0.35) |> OpsAlpha.alpha |> String.fromFloat


example2SourceCode : String
example2SourceCode =
    """Types.RGBColor (Color.rgba 1 0 0 0.35)
 |> OpsAlpha.alpha """


example2Output : List (Html.Html msg)
example2Output =
    [ Html.text """0.35 : Float """ ]


example3 : List (Html.Html msg)
example3 =
    Page.example example3Code example3SourceCode example3Output "has-text-white"


example3Code : String
example3Code =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsLightness.darken 1.0 |> ToHex.toHex


example3SourceCode : String
example3SourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBColor W3CX11.black)
 |> OpsLightness.darken 1.0
 |> ToHex.toHex """


example3Output : List (Html.Html msg)
example3Output =
    [ Html.text """"#c93384" : String  """ ]


example4 : List (Html.Html msg)
example4 =
    Page.example example4Code example4SourceCode example4Output "has-text-white"


example4Code : String
example4Code =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsLightness.darken 2.0 |> ToHex.toHex


example4SourceCode : String
example4SourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBColor W3CX11.black)
 |> OpsLightness.darken 2.0
 |> ToHex.toHex """


example4Output : List (Html.Html msg)
example4Output =
    [ Html.text """"#c930058" : String  """ ]
