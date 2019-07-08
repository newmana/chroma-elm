module Route exposing
    ( Route(..)
    , fromUrl
    , parser
    )

import Html as Html
import Html.Attributes as HtmlAttributes
import Url as Url
import Url.Parser as UrlParser


type Route
    = Home
    | Chroma
    | Interpolator
    | Convertor
    | Colors


parser : UrlParser.Parser (Route -> a) a
parser =
    UrlParser.oneOf
        [ UrlParser.map Home UrlParser.top
        , UrlParser.map Chroma (UrlParser.s "chroma")
        , UrlParser.map Interpolator (UrlParser.s "ops")
        , UrlParser.map Convertor (UrlParser.s "convertor")
        , UrlParser.map Colors (UrlParser.s "colors")
        ]


fromUrl : Url.Url -> Maybe Route
fromUrl url =
    -- The RealWorld spec treats the fragment like a path.
    -- This makes it *literally* the path, so we can proceed
    -- with parsing as if it had been a normal path all along.
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> UrlParser.parse parser
