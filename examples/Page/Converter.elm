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
        , HtmlAttributes.class "is-four-fifths"
        ]
        ([ Html.h1
            [ HtmlAttributes.class "title" ]
            [ Html.text "Converter" ]
         , Html.p
            [ HtmlAttributes.class "subtitle" ]
            [ Html.text "Going to or from Color Spaces" ]
         ]
            ++ Page.example "has-text-black" hslaCode hslaSourceCode hslaOutput
            ++ Page.example "has-text-black" lchCode lchSourceCode lchOutput
            ++ Page.example "has-text-white" cmykCode cmykSourceCode cmykOutput
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Direct Conversion" ]
               ]
            ++ Page.p "HSLA to RGB"
            ++ Page.example "has-text-white" hsla2RgbCode hsla2RgbSourceCode hsla2RgbOutput
            ++ Page.p "LAB to RGB"
            ++ Page.example "has-text-white" lab2RgbCode lab2RgbSourceCode lab2RgbOutput
            ++ Page.p "LCH to RGB"
            ++ Page.example "has-text-black" lch2RgbCode lch2RgbSourceCode lch2RgbOutput
            ++ Page.p "CYMK to RGB"
            ++ Page.example "has-text-white" cymk2RgbCode cymk2RgbSourceCode cymk2RgbOutput
        )
    ]


hslaCode : String
hslaCode =
    { hueDegrees = 120.0, saturation = 1.0, lightness = 0.75, alpha = 1.0 } |> Types.HSLADegreesColor |> ToHex.toHex


hslaSourceCode : String
hslaSourceCode =
    """{ hueDegrees = 120.0, saturation = 1.0, lightness = 0.75, alpha = 1.0 }
 |> Types.HSLADegreesColor
 |> ToHex.toHex  """


hslaOutput : List (Html.Html msg)
hslaOutput =
    [ Html.text
        """"#80ff80" : String """
    ]


lchCode : String
lchCode =
    { luminance = 80.0, chroma = 25.0, hue = 200.0 } |> Types.LCHColor |> ToHex.toHex


lchSourceCode : String
lchSourceCode =
    """{ luminance = 80.0, chroma = 25.0, hue = 200.0 }
 |> Types.LCHColor
 |> ToHex.toHex  """


lchOutput : List (Html.Html msg)
lchOutput =
    [ Html.text
        """"#85d5d4" : String """
    ]


cmykCode : String
cmykCode =
    { cyan = 1.0, magenta = 0.5, yellow = 0.0, black = 0.2 } |> Types.CMYKColor |> ToHex.toHex


cmykSourceCode : String
cmykSourceCode =
    """{ cyan = 1.0, magenta = 0.5, yellow = 0.0, black = 0.2 }
 |> Types.CMYKColor
 |> ToHex.toHex  """


cmykOutput : List (Html.Html msg)
cmykOutput =
    [ Html.text
        """"#85d5d4" : String """
    ]


hsla2RgbCode : String
hsla2RgbCode =
    { hueDegrees = 330, saturation = 1.0, lightness = 0.6, alpha = 1.0 }
        |> Hsla2Rgb.hslaDegrees2rgb
        |> Types.RGBAColor
        |> ToHex.toHex


hsla2RgbSourceCode : String
hsla2RgbSourceCode =
    """{ hueDegrees = 330, saturation = 1.0, lightness = 0.6, alpha = 1.0 }
 |> Hsla2Rgb.hslaDegrees2rgb
 |> Types.RGBAColor
 |> ToHex.toHex  """


hsla2RgbOutput : List (Html.Html msg)
hsla2RgbOutput =
    [ Html.text
        """"#ff3399" : String """
    ]


lab2RgbCode : String
lab2RgbCode =
    { lightness = 53.26441024020836, labA = 80.19554477648022, labB = 64.03450787409496 }
        |> Lab2Rgb.lab2rgb
        |> Types.RGBAColor
        |> ToHex.toHex


lab2RgbSourceCode : String
lab2RgbSourceCode =
    """{ lightness = 53.26441024020836, labA = 80.19554477648022, labB = 64.03450787409496 }
 |> Lab2Rgb.lab2rgb
 |> Types.RGBAColor
 |> ToHex.toHex  """


lab2RgbOutput : List (Html.Html msg)
lab2RgbOutput =
    [ Html.text
        """"#ff000D" : String """
    ]


lch2RgbCode : String
lch2RgbCode =
    { luminance = 80.0, chroma = 40.0, hue = 130.0 }
        |> Lch2Lab.lch2lab
        |> Lab2Rgb.lab2rgb
        |> Types.RGBAColor
        |> ToHex.toHex


lch2RgbSourceCode : String
lch2RgbSourceCode =
    """{ luminance = 80.0, chroma = 40.0, hue = 130.0 }
 |> Lch2Lab.lch2lab
 |> Lab2Rgb.lab2rgb
 |> Types.RGBAColor
 |> ToHex.toHex  """


lch2RgbOutput : List (Html.Html msg)
lch2RgbOutput =
    [ Html.text
        """"#aad28c" : String """
    ]


cymk2RgbCode : String
cymk2RgbCode =
    { cyan = 0.2, magenta = 0.8, yellow = 0, black = 0 }
        |> Cmyk2Rgb.cmyk2rgb
        |> Types.RGBAColor
        |> ToHex.toHex


cymk2RgbSourceCode : String
cymk2RgbSourceCode =
    """{ cyan = 0.2, magenta = 0.8, yellow = 0, black = 0 }
 |> Cmyk2Rgb.cmyk2rgb
 |> Types.RGBAColor
 |> ToHex.toHex  """


cymk2RgbOutput : List (Html.Html msg)
cymk2RgbOutput =
    [ Html.text
        """"#cc33ff" : String """
    ]
