module Page.Colors exposing (content)

import Chroma.Colors.Brewer as Brewer
import Chroma.Colors.Cividis as Cividis
import Chroma.Colors.Cmocean as Cmocean
import Chroma.Colors.Inferno as Inferno
import Chroma.Colors.Magma as Magma
import Chroma.Colors.Parula as Parula
import Chroma.Colors.Plasma as Plasma
import Chroma.Colors.Sinebow as Sinebow
import Chroma.Colors.Turbo as Turbo
import Chroma.Colors.Viridis as Viridis
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Out.ToHex as ToHex
import Chroma.Scale as Scale
import Chroma.Types as Types
import Color as Color
import ColorBand as ColorBand
import Html as Html
import Html.Attributes as HtmlAttributes
import List.Nonempty as Nonempty
import Page.Page as Page


content : List (Html.Html msg)
content =
    [ Html.div
        [ HtmlAttributes.class "column"
        , HtmlAttributes.class "is-four-fifths"
        ]
        ([ Html.h1
            [ HtmlAttributes.class "title" ]
            [ Html.text "Colors" ]
         , Html.p
            [ HtmlAttributes.class "subtitle" ]
            [ Html.text "A wide range of color maps are available - here is a sample." ]
         , Html.p
            [ HtmlAttributes.class "subtitle" ]
            [ Html.text "Cmocean" ]
         ]
            ++ showColorMap "Cmocean.algae" "Cmocean alga color map" Cmocean.algae
            ++ showColorMap "Cmocean.turbid" "Cmocean turbid color map" Cmocean.turbid
            ++ showColorMap "Cmocean.balance" "Cmocean balance color map" Cmocean.balance
            ++ showColorMap "Cmocean.curl" "Cmocean curl color map" Cmocean.curl
            ++ showColorMap "Cmocean.phase" "Cmocean phase color map" Cmocean.phase
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Viridis " ]
               ]
            ++ showColorMap "Inferno.inferno" "Inferno color map" Inferno.inferno
            ++ showColorMap "Magma.magma" "Magma color map" Magma.magma
            ++ showColorMap "Plasma.plasma" "Plasma color map" Plasma.plasma
            ++ showColorMap "Viridis.viridis" "Viridis color map" Viridis.viridis
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Parula " ]
               ]
            ++ showColorMap "Parula.parula" "Parula color map" Parula.parula
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Cividis " ]
               ]
            ++ showContinuousColorMap "(Cividis.getColor >> Types.RGBAColor)" "Cividis color map" (Cividis.getColor >> Types.RGBAColor)
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Rainbow " ]
               ]
            ++ showContinuousColorMap "(Sinebow.getColor >> Types.RGBAColor)" "Sinebow color map" (Sinebow.getColor >> Types.RGBAColor)
            ++ showContinuousColorMap "(Turbo.getColor >> Types.RGBAColor)" "Turbo color map" (Turbo.getColor >> Types.RGBAColor)
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Brewer " ]
               ]
            ++ showColorMap "Brewer.ylGnBu" "Brewer ylGnBu color map" Brewer.ylGnBu
            ++ showColorMap "Brewer.blues" "Brewer blues color map" Brewer.blues
            ++ showColorMap "Brewer.brBG" "Brewer blues color map" Brewer.brBG
            ++ showColorMap "Brewer.accent" "Brewer accent color map" Brewer.accent
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "W3CX11" ]
               ]
            ++ Page.example "has-text-black" example13Code example13SourceCode example13Output
            ++ showColorMap "(Nonempty.Nonempty W3CX11.coral [ W3CX11.cornflowerblue ])" "" (Nonempty.Nonempty W3CX11.coral [ W3CX11.cornflowerblue ])
        )
    ]


showColorMap : String -> String -> Nonempty.Nonempty Color.Color -> List (Html.Html msg)
showColorMap functionName mapName colorMap =
    Page.example "has-text-black" "#f5f5f5" (showColorMapCode functionName) (executeColorMap colorMap mapName)


showColorMapCode : String -> String
showColorMapCode name =
    """{ colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor """ ++ name ++ """) }
 |> ColorBand.view
    """


executeColorMap : Nonempty.Nonempty Color.Color -> String -> List (Html.Html msg)
executeColorMap map name =
    [ ColorBand.view { colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor map) } ]
        ++ [ Html.text name ]


showContinuousColorMap : String -> String -> (Float -> Types.ExtColor) -> List (Html.Html msg)
showContinuousColorMap functionName mapName colorMap =
    Page.example "has-text-black" "#f5f5f5" (showContinuousColorMapCode functionName) (executeContinuousColorMapCode colorMap mapName)


showContinuousColorMapCode : String -> String
showContinuousColorMapCode name =
    """{ colours = Scale.ContinuousColor """ ++ name ++ """ }
 |> ColorBand.view
    """


executeContinuousColorMapCode : (Float -> Types.ExtColor) -> String -> List (Html.Html msg)
executeContinuousColorMapCode f name =
    [ ColorBand.view { colours = Scale.ContinuousColor f } ]
        ++ [ Html.text name ]


example6SourceCode : String
example6SourceCode =
    """{ colours = Scale.ContinuousColor (Cividis.getColor >> Types.RGBAColor) }
 |> ColorBand.view
    """


example6Output : List (Html.Html msg)
example6Output =
    [ ColorBand.view { colours = Scale.ContinuousColor (Cividis.getColor >> Types.RGBAColor) } ]
        ++ [ Html.text "Cividis color map" ]


example7SourceCode : String
example7SourceCode =
    """{ colours = Scale.ContinuousColor (Sinebow.getColor >> Types.RGBAColor) }
 |> ColorBand.view
    """


example7Output : List (Html.Html msg)
example7Output =
    [ ColorBand.view { colours = Scale.ContinuousColor (Sinebow.getColor >> Types.RGBAColor) } ]
        ++ [ Html.text "Sinebow color map" ]


example8SourceCode : String
example8SourceCode =
    """{ colours = Scale.ContinuousColor (Turbo.getColor >> Types.RGBAColor) }
 |> ColorBand.view
    """


example8Output : List (Html.Html msg)
example8Output =
    [ ColorBand.view { colours = Scale.ContinuousColor (Turbo.getColor >> Types.RGBAColor) } ]
        ++ [ Html.text "Turbo color map" ]


example13Code : String
example13Code =
    Types.RGBAColor W3CX11.darkseagreen |> ToHex.toHex


example13SourceCode : String
example13SourceCode =
    """Types.RGBAColor W3CX11.darkseagreen
 |> ToHex.toHex
    """


example13Output : List (Html.Html msg)
example13Output =
    [ Html.text """"#8fbc9f" : String """ ]
