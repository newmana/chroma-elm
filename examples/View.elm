module View exposing (view)

import Html as Html
import Html.Attributes as HtmlAttributes
import Model as Model
import Utils.Logo as Logo


view : Model.Model -> List (Html.Html msg) -> List (Html.Html msg)
view model content =
    [ Html.section
        [ HtmlAttributes.class "hero"
        , HtmlAttributes.class "is-primary"
        ]
        [ Html.div
            [ HtmlAttributes.class "section-body"
            ]
            [ Html.div
                [ HtmlAttributes.class "columns"
                , HtmlAttributes.class "is-vcentered"
                ]
                [ Html.div
                    [ HtmlAttributes.class "column"
                    , HtmlAttributes.class "is-9"
                    ]
                    [ Html.h1
                        [ HtmlAttributes.class "title"
                        , HtmlAttributes.style "padding" "0.75rem"
                        ]
                        [ Html.text "chroma-elm" ]
                    ]
                , Html.div
                    [ HtmlAttributes.class "column"
                    , HtmlAttributes.class "is-1"
                    , HtmlAttributes.class "has-text-right"
                    ]
                    [ Html.div
                        [ HtmlAttributes.class "columns"
                        , HtmlAttributes.class "is-variable"
                        , HtmlAttributes.class "is-1"
                        ]
                        [ Html.div
                            [ HtmlAttributes.class "column"
                            , HtmlAttributes.class "is-6"
                            , HtmlAttributes.class "has-text-right"
                            ]
                            [ Html.a
                                [ HtmlAttributes.href "https://package.elm-lang.org/packages/newmana/chroma-elm/latest"
                                , HtmlAttributes.target "_blank"
                                ]
                                [ Logo.logo 50
                                ]
                            ]
                        , Html.div
                            [ HtmlAttributes.class "column"
                            , HtmlAttributes.class "is-6"
                            , HtmlAttributes.class "has-text-left"
                            ]
                            [ Html.a
                                [ HtmlAttributes.href "https://package.elm-lang.org/packages/newmana/chroma-elm/latest"
                                , HtmlAttributes.target "_blank"
                                ]
                                [ Html.p
                                    []
                                    [ Html.span
                                        [ HtmlAttributes.class "is-size-5"
                                        , HtmlAttributes.class "has-text-weight-bold"
                                        , HtmlAttributes.class "has-text-white"
                                        ]
                                        [ Html.text "elm" ]
                                    ]
                                , Html.p
                                    []
                                    [ Html.span
                                        [ HtmlAttributes.class "is-size-7"
                                        , HtmlAttributes.class "has-text-weight-bold"
                                        , HtmlAttributes.class "has-text-white"
                                        ]
                                        [ Html.text "packages" ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                , Html.div
                    [ HtmlAttributes.class "column"
                    , HtmlAttributes.class "is-1"
                    , HtmlAttributes.class "has-text-centered"
                    ]
                    [ Html.a
                        [ HtmlAttributes.href "https://github.com/newmana/chroma-elm"
                        , HtmlAttributes.target "_blank"
                        , HtmlAttributes.class "button"
                        , HtmlAttributes.class "is-primary"
                        , HtmlAttributes.class "is-large"
                        ]
                        [ Html.text "Github" ]
                    ]
                ]
            ]
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
                    , HtmlAttributes.class "is-one-fifth"
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
                        [ Html.text "API"
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
                            , HtmlAttributes.href "#/colors"
                            ]
                            [ Html.text "Colors" ]
                        , Html.a
                            [ HtmlAttributes.class "list-item"
                            , HtmlAttributes.href "#/converter"
                            ]
                            [ Html.text "Converter" ]
                        , Html.a
                            [ HtmlAttributes.class "list-item"
                            , HtmlAttributes.href "#/ops"
                            ]
                            [ Html.text "Color Operations" ]
                        ]
                    ]
                 ]
                    ++ content
                )
            ]
        ]
    ]
