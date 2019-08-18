module Msg exposing (Msg(..))

import Browser as Browser
import Route as Route
import Url as Url


type Msg
    = ChangedRoute (Maybe Route.Route)
    | ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | GetStartedMsg
    | ChromaMsg
    | InterpolatorMsg
    | ConverterMsg
    | ColorsMsg
