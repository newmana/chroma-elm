module Page.Page exposing (example, p)

import Html as Html
import Html.Attributes as HtmlAttributes


p : String -> List (Html.Html msg)
p text =
    [ Html.div
        [ HtmlAttributes.class "content" ]
        [ Html.p
            []
            [ Html.text text ]
        ]
    ]


example : String -> String -> List (Html.Html msg) -> String -> List (Html.Html msg)
example code source output textColor =
    [ Html.div
        [ HtmlAttributes.class "container"
        ]
        [ Html.div
            [ HtmlAttributes.class "columns"
            ]
            [ Html.div
                [ HtmlAttributes.class "column"
                , HtmlAttributes.class "is-three-fifths"
                ]
                [ Html.div
                    [ HtmlAttributes.class "box"
                    ]
                    [ Html.pre
                        []
                        [ Html.code
                            []
                            [ Html.text source
                            ]
                        ]
                    ]
                ]
            , Html.div
                [ HtmlAttributes.class "column"
                , HtmlAttributes.class "is-two-fifths"
                ]
                [ Html.div
                    [ HtmlAttributes.class "box"
                    , HtmlAttributes.class "is-shadowless"
                    ]
                    [ Html.pre
                        []
                        [ Html.code
                            [ HtmlAttributes.class textColor
                            , HtmlAttributes.style "background-color" code
                            ]
                            output
                        ]
                    ]
                ]
            ]
        ]
    ]
