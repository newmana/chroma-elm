module View exposing (view)

import Browser
import Html as Html
import Html.Attributes as HtmlAttributes
import Model as Model


view : Model.Model -> List (Html.Html msg) -> Html.Html msg
view model content =
    Html.div []
        [ Html.nav
            [ HtmlAttributes.class "navbar"
            , HtmlAttributes.class "is-transparent"
            , HtmlAttributes.class "is-fixed-top"
            ]
            [ Html.div [ HtmlAttributes.class "navbar-brand" ]
                [ Html.h1
                    [ HtmlAttributes.class "title"
                    , HtmlAttributes.class "is-2"
                    ]
                    [ Html.text "chroma-elm" ]
                ]
            , Html.div [ HtmlAttributes.class "navbar-menu" ] []
            ]
        , Html.section
            [ HtmlAttributes.class "section"
            ]
            [ Html.div
                [ HtmlAttributes.class "container"
                ]
                [ Html.div
                    [ HtmlAttributes.class "columns"
                    ]
                    ([ Html.div
                        [ HtmlAttributes.class "column"
                        ]
                        [ Html.h2
                            [ HtmlAttributes.class "title"
                            , HtmlAttributes.class "is-hoverable"
                            , HtmlAttributes.class "is-4"
                            ]
                            [ Html.a
                                [ HtmlAttributes.href "#/"
                                ]
                                [ Html.text "Getting Started" ]
                            ]
                        , Html.h3
                            [ HtmlAttributes.class "title"
                            , HtmlAttributes.class "is-hoverable"
                            , HtmlAttributes.class "is-4"
                            ]
                            [ Html.a
                                [ HtmlAttributes.href "#/api"
                                ]
                                [ Html.text "API" ]
                            ]
                        , Html.div
                            [ HtmlAttributes.class "list"
                            , HtmlAttributes.class "is-hoverable"
                            ]
                            [ Html.a
                                [ HtmlAttributes.class "list-item"
                                , HtmlAttributes.href "#/chroma"
                                ]
                                [ Html.text "Chroma" ]
                            , Html.a
                                [ HtmlAttributes.class "list-item"
                                , HtmlAttributes.href "#/interpolator"
                                ]
                                [ Html.text "Interpolator" ]
                            , Html.a
                                [ HtmlAttributes.class "list-item"
                                , HtmlAttributes.href "#/convertor"
                                ]
                                [ Html.text "Convertor" ]
                            , Html.a
                                [ HtmlAttributes.class "list-item"
                                , HtmlAttributes.href "#/colors"
                                ]
                                [ Html.text "Colors" ]
                            ]
                        ]
                     ]
                        ++ content
                    )
                ]
            ]
        ]
