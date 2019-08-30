module Page.Colors exposing (content)

import Chroma.Colors.Brewer as Brewer
import Chroma.Colors.Cividis as Cividis
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
import ColorBand as ColorBand
import Html as Html
import Html.Attributes as HtmlAttributes
import List.Nonempty as Nonempty
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
            [ Html.text "Viridis" ]
         ]
            ++ Page.example "has-text-black" "#f5f5f5" example1SourceCode example1Output
            ++ Page.example "has-text-black" "#f5f5f5" example2SourceCode example2Output
            ++ Page.example "has-text-black" "#f5f5f5" example3SourceCode example3Output
            ++ Page.example "has-text-black" "#f5f5f5" example4SourceCode example4Output
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Parula " ]
               ]
            ++ Page.example "has-text-black" "#f5f5f5" example5SourceCode example5Output
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Cividis " ]
               ]
            ++ Page.example "has-text-black" "#f5f5f5" example6SourceCode example6Output
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Rainbow " ]
               ]
            ++ Page.example "has-text-black" "#f5f5f5" example7SourceCode example7Output
            ++ Page.example "has-text-black" "#f5f5f5" example8SourceCode example8Output
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "Brewer " ]
               ]
            ++ Page.example "has-text-black" "#f5f5f5" example9SourceCode example9Output
            ++ Page.example "has-text-black" "#f5f5f5" example10SourceCode example10Output
            ++ Page.example "has-text-black" "#f5f5f5" example11SourceCode example11Output
            ++ Page.example "has-text-black" "#f5f5f5" example12SourceCode example12Output
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "W3CX11" ]
               ]
            ++ Page.example "has-text-black" example13Code example13SourceCode example13Output
            ++ Page.example "has-text-black" "#f5f5f5" example14SourceCode example14Output
        )
    ]


example1SourceCode : String
example1SourceCode =
    """{ colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Inferno.inferno) }
 |> ColorBand.view
    """


example1Output : List (Html.Html msg)
example1Output =
    [ ColorBand.view { colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Inferno.inferno) } ]
        ++ [ Html.text "Inferno color map" ]


example2SourceCode : String
example2SourceCode =
    """{ colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Magma.magma) }
 |> ColorBand.view
    """


example2Output : List (Html.Html msg)
example2Output =
    [ ColorBand.view { colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Magma.magma) } ]
        ++ [ Html.text "Magma color map" ]


example3SourceCode : String
example3SourceCode =
    """{ colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Plasma.plasma) }
 |> ColorBand.view
    """


example3Output : List (Html.Html msg)
example3Output =
    [ ColorBand.view { colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Plasma.plasma) } ]
        ++ [ Html.text "Plasma color map" ]


example4SourceCode : String
example4SourceCode =
    """{ colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Viridis.viridis) }
 |> ColorBand.view
    """


example4Output : List (Html.Html msg)
example4Output =
    [ ColorBand.view { colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Viridis.viridis) } ]
        ++ [ Html.text "Viridis color map" ]


example5SourceCode : String
example5SourceCode =
    """{ colours = colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Parula.parula) }
 |> ColorBand.view
    """


example5Output : List (Html.Html msg)
example5Output =
    [ ColorBand.view { colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Parula.parula) } ]
        ++ [ Html.text "Parula color map" ]


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


example9SourceCode : String
example9SourceCode =
    """{ colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Brewer.orRd) }
 |> ColorBand.view
    """


example9Output : List (Html.Html msg)
example9Output =
    [ ColorBand.view { colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Brewer.orRd) } ]
        ++ [ Html.text "Brewer orRd color map" ]


example10SourceCode : String
example10SourceCode =
    """{ colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Brewer.puBuGn) }
 |> ColorBand.view
    """


example10Output : List (Html.Html msg)
example10Output =
    [ ColorBand.view { colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Brewer.puBuGn) } ]
        ++ [ Html.text "Brewer orRd color map" ]


example11SourceCode : String
example11SourceCode =
    """{ colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Brewer.rdYlGn) }
 |> ColorBand.view
    """


example11Output : List (Html.Html msg)
example11Output =
    [ ColorBand.view { colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Brewer.rdYlGn) } ]
        ++ [ Html.text "Brewer rdYlGn color map" ]


example12SourceCode : String
example12SourceCode =
    """{ colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Brewer.pastel1) }
 |> ColorBand.view
    """


example12Output : List (Html.Html msg)
example12Output =
    [ ColorBand.view { colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor Brewer.pastel1) } ]
        ++ [ Html.text "Brewer pastel1 color map" ]


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


example14SourceCode : String
example14SourceCode =
    """{ colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor (Nonempty.Nonempty W3CX11.coral [ W3CX11.cornflowerblue ])) }
 |> ColorBand.view
    """


example14Output : List (Html.Html msg)
example14Output =
    [ ColorBand.view { colours = Scale.DiscreteColor (Nonempty.map Types.RGBAColor (Nonempty.Nonempty W3CX11.coral [ W3CX11.cornflowerblue ])) } ]
