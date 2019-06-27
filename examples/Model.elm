module Model exposing
    ( Content(..)
    , Model
    , defaultModel
    )

import Browser.Navigation as BrowserNavigation


type Content
    = GetStarted
    | Chroma
    | Interpolator
    | Convertor
    | Colors


type alias Model =
    { page : Content
    , key : BrowserNavigation.Key
    }


defaultModel : BrowserNavigation.Key -> Model
defaultModel newKey =
    { page = GetStarted
    , key = newKey
    }
