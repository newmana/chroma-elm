-- Main.elm


module Main exposing (main)

import Browser as Browser
import Browser.Navigation as BrowserNavigation
import Html as Html
import Json.Decode as JsonDecode
import Model as Model
import Page.Chroma as PageChroma
import Page.Color as PageColor
import Page.Convertor as Convertor
import Page.GettingStarted as PageGettingStarted
import Page.Interpolator as PageInterpolator
import Route as Route
import Url as Url
import View as View


type Msg
    = ChangedRoute (Maybe Route.Route)
    | ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | GetStartedMsg
    | ChromaMsg
    | InterpolatorMsg
    | ConvertorMsg
    | ColorsMsg


update : Msg -> Model.Model -> ( Model.Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    case url.fragment of
                        Nothing ->
                            ( model, Cmd.none )

                        Just _ ->
                            ( model
                            , BrowserNavigation.pushUrl model.key (Url.toString url)
                            )

                Browser.External href ->
                    ( model
                    , BrowserNavigation.load href
                    )

        ChangedUrl url ->
            changeUrl url model.key

        GetStartedMsg ->
            ( { model | page = Model.GetStarted }, Cmd.none )

        ChromaMsg ->
            ( { model | page = Model.Chroma }, Cmd.none )

        InterpolatorMsg ->
            ( { model | page = Model.Interpolator }, Cmd.none )

        ConvertorMsg ->
            ( { model | page = Model.Convertor }, Cmd.none )

        ColorsMsg ->
            ( { model | page = Model.Colors }, Cmd.none )

        _ ->
            ( model, Cmd.none )


init : flags -> Url.Url -> BrowserNavigation.Key -> ( Model.Model, Cmd Msg )
init flags url nav =
    changeUrl url nav


changeUrl : Url.Url -> BrowserNavigation.Key -> ( Model.Model, Cmd Msg )
changeUrl url nav =
    let
        maybeRoute =
            Route.fromUrl url
    in
    case maybeRoute of
        Nothing ->
            ( Model.defaultModel nav, Cmd.none )

        Just r ->
            case r of
                Route.Home ->
                    update GetStartedMsg (Model.defaultModel nav)

                Route.Chroma ->
                    update ChromaMsg (Model.defaultModel nav)

                Route.Interpolator ->
                    update InterpolatorMsg (Model.defaultModel nav)

                Route.Convertor ->
                    update ConvertorMsg (Model.defaultModel nav)

                Route.Colors ->
                    update ColorsMsg (Model.defaultModel nav)


subscriptions model =
    Sub.none


view : Model.Model -> Browser.Document msg
view model =
    let
        page =
            case model.page of
                Model.GetStarted ->
                    PageGettingStarted.content

                Model.Chroma ->
                    PageChroma.content

                Model.Interpolator ->
                    PageInterpolator.content

                Model.Convertor ->
                    Convertor.content

                Model.Colors ->
                    PageColor.content
    in
    { title = "chroma-elm"
    , body = [ View.view model page ]
    }


main : Program JsonDecode.Value Model.Model Msg
main =
    Browser.application
        { init = init
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
