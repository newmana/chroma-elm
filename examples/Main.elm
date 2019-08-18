-- Main.elm


module Main exposing (main)

import Browser as Browser
import Browser.Navigation as BrowserNavigation
import Json.Decode as JsonDecode
import Model as Model
import Msg as Msg
import Page.Chroma as PageChroma
import Page.ColorOperations as PageInterpolator
import Page.Colors as PageColor
import Page.Converter as Convertor
import Page.GettingStarted as PageGettingStarted
import Route as Route
import Url as Url
import View as View


update : Msg.Msg -> Model.Model -> ( Model.Model, Cmd Msg.Msg )
update msg model =
    case msg of
        Msg.ClickedLink urlRequest ->
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

        Msg.ChangedUrl url ->
            changeUrl url model.key

        Msg.GetStartedMsg ->
            ( { model | page = Model.GetStarted }, Cmd.none )

        Msg.ChromaMsg ->
            ( { model | page = Model.Chroma }, Cmd.none )

        Msg.InterpolatorMsg ->
            ( { model | page = Model.Interpolator }, Cmd.none )

        Msg.ConverterMsg ->
            ( { model | page = Model.Converter }, Cmd.none )

        Msg.ColorsMsg ->
            ( { model | page = Model.Colors }, Cmd.none )

        _ ->
            ( model, Cmd.none )


init : flags -> Url.Url -> BrowserNavigation.Key -> ( Model.Model, Cmd Msg.Msg )
init flags url nav =
    changeUrl url nav


changeUrl : Url.Url -> BrowserNavigation.Key -> ( Model.Model, Cmd Msg.Msg )
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
                    update Msg.GetStartedMsg (Model.defaultModel nav)

                Route.Chroma ->
                    update Msg.ChromaMsg (Model.defaultModel nav)

                Route.Interpolator ->
                    update Msg.InterpolatorMsg (Model.defaultModel nav)

                Route.Converter ->
                    update Msg.ConverterMsg (Model.defaultModel nav)

                Route.Colors ->
                    update Msg.ColorsMsg (Model.defaultModel nav)


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

                Model.Converter ->
                    Convertor.content

                Model.Colors ->
                    PageColor.content
    in
    { title = "chroma-elm"
    , body = View.view model page
    }


main : Program JsonDecode.Value Model.Model Msg.Msg
main =
    Browser.application
        { init = init
        , onUrlChange = Msg.ChangedUrl
        , onUrlRequest = Msg.ClickedLink
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
