module Page.Colors exposing (content)

import Chroma.Colors.Brewer as Brewer
import Chroma.Colors.Inferno as Inferno
import Chroma.Colors.Magma as Magma
import Chroma.Colors.Plasma as Plasma
import Chroma.Colors.Viridis as Viridis
import Chroma.Colors.W3CX11 as W3CX11
import Chroma.Converter.Out.ToHex as ToHex
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
                    [ Html.text "Brewer " ]
               ]
            ++ Page.example "has-text-black" "#f5f5f5" example5SourceCode example5Output
            ++ Page.example "has-text-black" "#f5f5f5" example6SourceCode example6Output
            ++ Page.example "has-text-black" "#f5f5f5" example7SourceCode example7Output
            ++ Page.example "has-text-black" "#f5f5f5" example8SourceCode example8Output
            ++ Page.p "\u{00A0}"
            ++ [ Html.p
                    [ HtmlAttributes.class "subtitle" ]
                    [ Html.text "W3CX11" ]
               ]
            ++ Page.example "has-text-black" example9Code example9SourceCode example9Output
            ++ Page.example "has-text-black" "#f5f5f5" example10SourceCode example10Output
        )
    ]


example1SourceCode : String
example1SourceCode =
    """{ colours = Nonempty.map Types.RGBAColor Inferno.inferno }
 |> ColorBand.view
    """


example1Output : List (Html.Html msg)
example1Output =
    [ ColorBand.view { colours = Nonempty.map Types.RGBAColor Inferno.inferno } ]
        ++ [ Html.text "Inferno Colormap" ]


example2SourceCode : String
example2SourceCode =
    """{ colours = Nonempty.map Types.RGBAColor Magma.magma }
 |> ColorBand.view
    """


example2Output : List (Html.Html msg)
example2Output =
    [ ColorBand.view { colours = Nonempty.map Types.RGBAColor Magma.magma } ]
        ++ [ Html.text "Magma Colormap" ]


example3SourceCode : String
example3SourceCode =
    """{ colours = Nonempty.map Types.RGBAColor Magma.magma }
 |> ColorBand.view
    """


example3Output : List (Html.Html msg)
example3Output =
    [ ColorBand.view { colours = Nonempty.map Types.RGBAColor Plasma.plasma } ]
        ++ [ Html.text "Plasma Colormap" ]


example4SourceCode : String
example4SourceCode =
    """{ colours = Nonempty.map Types.RGBAColor Viridis.viridis }
 |> ColorBand.view
    """


example4Output : List (Html.Html msg)
example4Output =
    [ ColorBand.view { colours = Nonempty.map Types.RGBAColor Viridis.viridis } ]
        ++ [ Html.text "Viridis Colormap" ]


example5SourceCode : String
example5SourceCode =
    """{ colours = Nonempty.map Types.RGBAColor Brewer.orRd }
 |> ColorBand.view
    """


example5Output : List (Html.Html msg)
example5Output =
    [ ColorBand.view { colours = Nonempty.map Types.RGBAColor Brewer.orRd } ]
        ++ [ Html.text "Brewer orRd Colormap" ]


example6SourceCode : String
example6SourceCode =
    """{ colours = Nonempty.map Types.RGBAColor Brewer.puBuGn }
 |> ColorBand.view
    """


example6Output : List (Html.Html msg)
example6Output =
    [ ColorBand.view { colours = Nonempty.map Types.RGBAColor Brewer.puBuGn } ]
        ++ [ Html.text "Brewer orRd Colormap" ]


example7SourceCode : String
example7SourceCode =
    """{ colours = Nonempty.map Types.RGBAColor Brewer.rdYlGn }
 |> ColorBand.view
    """


example7Output : List (Html.Html msg)
example7Output =
    [ ColorBand.view { colours = Nonempty.map Types.RGBAColor Brewer.rdYlGn } ]
        ++ [ Html.text "Brewer rdYlGn Colormap" ]


example8SourceCode : String
example8SourceCode =
    """{ colours = Nonempty.map Types.RGBAColor Brewer.pastel1 }
 |> ColorBand.view
    """


example8Output : List (Html.Html msg)
example8Output =
    [ ColorBand.view { colours = Nonempty.map Types.RGBAColor Brewer.pastel1 } ]
        ++ [ Html.text "Brewer pastel1 Colormap" ]


example9Code : String
example9Code =
    Types.RGBAColor W3CX11.darkseagreen |> ToHex.toHex


example9SourceCode : String
example9SourceCode =
    """Types.RGBAColor W3CX11.darkseagreen
 |> ToHex.toHex
    """


example9Output : List (Html.Html msg)
example9Output =
    [ Html.text """"#8fbc9f" : String """ ]


example10SourceCode : String
example10SourceCode =
    """{ colours = Nonempty.map Types.RGBAColor (Nonempty.Nonempty W3CX11.coral [ W3CX11.cornflowerblue ]) }
 |> ColorBand.view
    """


example10Output : List (Html.Html msg)
example10Output =
    [ ColorBand.view { colours = Nonempty.map Types.RGBAColor (Nonempty.Nonempty W3CX11.coral [ W3CX11.cornflowerblue ]) } ]
