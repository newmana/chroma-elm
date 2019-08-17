module Page.Converter exposing (content)

import Chroma.Chroma as Chroma
import Chroma.Converter.In.Cmyk2Rgb as Cmyk2Rgb
import Chroma.Converter.In.Hsla2Rgb as Hsla2Rgb
import Chroma.Converter.In.Lab2Rgb as Lab2Rgb
import Chroma.Converter.In.Lch2Lab as Lch2Lab
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Converter.Out.ToHsla as ToHsla
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
            [ Html.text "Converter" ]
         , Html.p
            [ HtmlAttributes.class "subtitle" ]
            [ Html.text "Going to or from Color Spaces" ]
         ]
            ++ Page.p "HSLA to RGB"
            ++ Page.example "has-text-white" example1Code example1SourceCode example1Output
            ++ Page.p "LAB to RGB"
            ++ Page.example "has-text-white" example2Code example2SourceCode example2Output
            ++ Page.p "LCH to RGB"
            ++ Page.example "has-text-black" example3Code example3SourceCode example3Output
            ++ Page.p "CYMK to RGB"
            ++ Page.example "has-text-white" example4Code example4SourceCode example4Output
        )
    ]


example1Code : String
example1Code =
    { hueDegrees = 330, saturation = 1.0, lightness = 0.6, alpha = 1.0 }
        |> Hsla2Rgb.hslaDegrees2rgb
        |> Types.RGBAColor
        |> ToHex.toHex


example1SourceCode : String
example1SourceCode =
    """{ hueDegrees = 330, saturation = 1.0, lightness = 0.6, alpha = 1.0 }
 |> Hsla2Rgb.hslaDegrees2rgb
 |> Types.RGBAColor
 |> ToHex.toHex  """


example1Output : List (Html.Html msg)
example1Output =
    [ Html.text
        """"#ff3399" : String """
    ]


example2Code : String
example2Code =
    { lightness = 53.26441024020836, labA = 80.19554477648022, labB = 64.03450787409496 }
        |> Lab2Rgb.lab2rgb
        |> Types.RGBAColor
        |> ToHex.toHex


example2SourceCode : String
example2SourceCode =
    """{ lightness = 53.26441024020836, labA = 80.19554477648022, labB = 64.03450787409496 }
 |> Lab2Rgb.lab2rgb
 |> Types.RGBAColor
 |> ToHex.toHex  """


example2Output : List (Html.Html msg)
example2Output =
    [ Html.text
        """"#ff000D" : String """
    ]


example3Code : String
example3Code =
    { luminance = 80.0, chroma = 40.0, hue = 130.0 }
        |> Lch2Lab.lch2lab
        |> Lab2Rgb.lab2rgb
        |> Types.RGBAColor
        |> ToHex.toHex


example3SourceCode : String
example3SourceCode =
    """{ luminance = 80.0, chroma = 40.0, hue = 130.0 }
 |> Lch2Lab.lch2lab
 |> Lab2Rgb.lab2rgb
 |> Types.RGBAColor
 |> ToHex.toHex  """


example3Output : List (Html.Html msg)
example3Output =
    [ Html.text
        """"#aad28c" : String """
    ]


example4Code : String
example4Code =
    { cyan = 0.2, magenta = 0.8, yellow = 0, black = 0 }
        |> Cmyk2Rgb.cmyk2rgb
        |> Types.RGBAColor
        |> ToHex.toHex


example4SourceCode : String
example4SourceCode =
    """{ cyan = 0.2, magenta = 0.8, yellow = 0, black = 0 }
 |> Cmyk2Rgb.cmyk2rgb
 |> Types.RGBAColor
 |> ToHex.toHex  """


example4Output : List (Html.Html msg)
example4Output =
    [ Html.text
        """"#cc33ff" : String """
    ]
