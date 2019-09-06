module Page.ColorOperations exposing (content)

import Chroma.Chroma as Chroma
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Converter.Out.ToLab as ToLab
import Chroma.Ops.Alpha as OpsAlpha
import Chroma.Ops.Lightness as OpsLightness
import Chroma.Ops.Luminance as OpsLuminance
import Chroma.Ops.Numeric as OpsNumeric
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
         , Html.p
            [ HtmlAttributes.class "subtitle" ]
            [ Html.text "Alpha" ]
         ]
            ++ setAlpha
            ++ getAlpha
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Lightness" ]
               ]
            ++ darkenOne
            ++ darkenTwo
            ++ brightenTwo
            ++ brightenThree
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Luminance" ]
               ]
            ++ contrastLuminance
            ++ getLuminance
            ++ setLuminanceRgb
            ++ setLuminanceLab
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Numeric" ]
               ]
            ++ num
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Saturate" ]
               ]
            ++ saturateTwo
            ++ desaturateThree
        )
    ]


setAlpha : List (Html.Html msg)
setAlpha =
    Page.example "has-text-white" setAlphaCode setAlphaSourceCode setAlphaOutput


setAlphaCode : String
setAlphaCode =
    Chroma.chroma "red" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsAlpha.setAlpha 0.5 |> ToHex.toHexAlpha


setAlphaSourceCode : String
setAlphaSourceCode =
    """Chroma.chroma "red"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsLightness.alpha 0.5
 |> ToHex.toHexAlpha  """


setAlphaOutput : List (Html.Html msg)
setAlphaOutput =
    [ Html.text ("\"" ++ setAlphaCode ++ "\" : String ") ]


getAlpha : List (Html.Html msg)
getAlpha =
    Page.example "has-text-black" "" getAlphaSourceCode getAlphaOutput


getAlphaCode : String
getAlphaCode =
    Types.RGBAColor (Color.rgba 1 0 0 0.35) |> OpsAlpha.alpha |> String.fromFloat


getAlphaSourceCode : String
getAlphaSourceCode =
    """Types.RGBAColor (Color.rgba 1 0 0 0.35)
 |> OpsAlpha.alpha """


getAlphaOutput : List (Html.Html msg)
getAlphaOutput =
    [ Html.text (getAlphaCode ++ " : Float ") ]


darkenOne : List (Html.Html msg)
darkenOne =
    Page.example "has-text-white" darkenOneCode darkenOneSourceCode darkenOneOutput


darkenOneCode : String
darkenOneCode =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsLightness.darken 1.0 |> ToHex.toHex


darkenOneSourceCode : String
darkenOneSourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsLightness.darken 1.0
 |> ToHex.toHex """


darkenOneOutput : List (Html.Html msg)
darkenOneOutput =
    [ Html.text """"#c93384" : String  """ ]


darkenTwo : List (Html.Html msg)
darkenTwo =
    Page.example "has-text-white" darkenTwoCode darkenTwoSourceCode darkenTwoOutput


darkenTwoCode : String
darkenTwoCode =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsLightness.darken 2.0 |> ToHex.toHex


darkenTwoSourceCode : String
darkenTwoSourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsLightness.darken 2.0
 |> ToHex.toHex """


darkenTwoOutput : List (Html.Html msg)
darkenTwoOutput =
    [ Html.text """"#c930058" : String  """ ]


brightenTwo : List (Html.Html msg)
brightenTwo =
    Page.example "has-text-black" brightenTwoCode brightenTwoSourceCode brightenTwoOutput


brightenTwoCode : String
brightenTwoCode =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsLightness.brighten 2.0 |> ToHex.toHex


brightenTwoSourceCode : String
brightenTwoSourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsLightness.brighten 2.0
 |> ToHex.toHex """


brightenTwoOutput : List (Html.Html msg)
brightenTwoOutput =
    [ Html.text """"#ffd1ff" : String  """ ]


brightenThree : List (Html.Html msg)
brightenThree =
    Page.example "has-text-black" brightenThreeCode brightenThreeSourceCode brightenThreeOutput


brightenThreeCode : String
brightenThreeCode =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsLightness.brighten 3.0 |> ToHex.toHex


brightenThreeSourceCode : String
brightenThreeSourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsLightness.brighten 3.0
 |> ToHex.toHex """


brightenThreeOutput : List (Html.Html msg)
brightenThreeOutput =
    [ Html.text """"#ffffff" : String  """ ]


getLuminance : List (Html.Html msg)
getLuminance =
    Page.example "has-text-black" "" getLuminanceSourceCode getLuminanceOutput


getLuminanceCode : String
getLuminanceCode =
    Types.RGBAColor W3CX11.aquamarine |> OpsLuminance.luminance |> String.fromFloat


getLuminanceSourceCode : String
getLuminanceSourceCode =
    """Types.RGBAColor W3CX11.aquamarine
 |> OpsLuminance.luminance """


getLuminanceOutput : List (Html.Html msg)
getLuminanceOutput =
    [ Html.text (getLuminanceCode ++ " : Float ") ]


contrastLuminance : List (Html.Html msg)
contrastLuminance =
    Page.example "has-text-black" "" contrastLuminanceSourceCode contrastLuminanceOutput


contrastLuminanceCode : String
contrastLuminanceCode =
    OpsLuminance.contrast (Types.RGBAColor W3CX11.aquamarine) (Types.RGBAColor W3CX11.black) |> String.fromFloat


contrastLuminanceSourceCode : String
contrastLuminanceSourceCode =
    """OpsLuminance.contrast (Types.RGBAColor W3CX11.aquamarine) (Types.RGBAColor W3CX11.black) """


contrastLuminanceOutput : List (Html.Html msg)
contrastLuminanceOutput =
    [ Html.text (contrastLuminanceCode ++ " : Float ") ]


setLuminanceRgb : List (Html.Html msg)
setLuminanceRgb =
    Page.example "has-text-black" setLuminanceRgbCode setLuminanceRgbSourceCode setLuminanceRgbOutput


setLuminanceRgbCode : String
setLuminanceRgbCode =
    Types.RGBAColor W3CX11.aquamarine |> OpsLuminance.setLuminance 0.5 |> ToHex.toHex


setLuminanceRgbSourceCode : String
setLuminanceRgbSourceCode =
    """Types.RGBAColor W3CX11.aquamarine
 |> OpsLuminance.setLuminance 0.5
 |> ToHex.toHex """


setLuminanceRgbOutput : List (Html.Html msg)
setLuminanceRgbOutput =
    [ Html.text """"#67ceab" : String  """ ]


setLuminanceLab : List (Html.Html msg)
setLuminanceLab =
    Page.example "has-text-black" setLuminanceLabCode setLuminanceLabSourceCode setLuminanceLabOutput


setLuminanceLabCode : String
setLuminanceLabCode =
    Types.RGBAColor W3CX11.aquamarine |> ToLab.toLab |> Types.LABColor |> OpsLuminance.setLuminance 0.5 |> ToHex.toHex


setLuminanceLabSourceCode : String
setLuminanceLabSourceCode =
    """Types.RGBAColor W3CX11.aquamarine
 |> ToLab.toLab
 |> Types.LABColor
 |> OpsLuminance.setLuminance 0.5
 |> ToHex.toHex """


setLuminanceLabOutput : List (Html.Html msg)
setLuminanceLabOutput =
    [ Html.text """"#67ceab" : String  """ ]


num : List (Html.Html msg)
num =
    Page.example "has-text-black" "" numSourceCode numOutput


numCode : String
numCode =
    OpsNumeric.num (Types.RGBAColor W3CX11.aquamarine) |> String.fromInt


numSourceCode : String
numSourceCode =
    """Color.num (Types.RGBAColor W3CX11.aquamarine) """


numOutput : List (Html.Html msg)
numOutput =
    [ Html.text (numCode ++ " : Int ") ]


saturateTwo : List (Html.Html msg)
saturateTwo =
    Page.example "has-text-white" saturateTwoCode saturateTwoSourceCode saturateTwoOutput


saturateTwoCode : String
saturateTwoCode =
    Chroma.chroma "slategray" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsSaturate.saturate 2.0 |> ToHex.toHex


saturateTwoSourceCode : String
saturateTwoSourceCode =
    """Chroma.chroma "slategray"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsSaturate.saturate 2.0
 |> ToHex.toHex """


saturateTwoOutput : List (Html.Html msg)
saturateTwoOutput =
    [ Html.text """"#0087cd" : String  """ ]


desaturateThree : List (Html.Html msg)
desaturateThree =
    Page.example "has-text-white" desaturateThreeCode desaturateThreeSourceCode desaturateThreeOutput


desaturateThreeCode : String
desaturateThreeCode =
    Chroma.chroma "hotpink" |> Result.withDefault (Types.RGBAColor W3CX11.black) |> OpsSaturate.desaturate 3.0 |> ToHex.toHex


desaturateThreeSourceCode : String
desaturateThreeSourceCode =
    """Chroma.chroma "hotpink"
 |> Result.withDefault (Types.RGBAColor W3CX11.black)
 |> OpsSaturate.desaturate 3.0
 |> ToHex.toHex """


desaturateThreeOutput : List (Html.Html msg)
desaturateThreeOutput =
    [ Html.text """"#b199a3" : String  """ ]
