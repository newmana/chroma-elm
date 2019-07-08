module Page.ColorOperations exposing (content)

import Html as Html
import Html.Attributes as HtmlAttributes


content : List (Html.Html msg)
content =
    [ Html.div
        [ HtmlAttributes.class "column"
        ]
        [ Html.h1
            [ HtmlAttributes.class "title" ]
            [ Html.text "Color Operations" ]
        , Html.p
            [ HtmlAttributes.class "subtitle" ]
            [ Html.text "Functions to modify an existing color value" ]
        ]
    ]
