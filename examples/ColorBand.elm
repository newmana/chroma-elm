module ColorBand exposing (ColorBandConfig, view)

import Chroma.Chroma as Chroma
import Chroma.Converter.Out.ToHex as ChromaToHex
import Chroma.Limits.Analyze as Analyze
import Chroma.Scale as Scale
import Chroma.Types as ChromaTypes
import Html
import Html.Attributes as HtmlAttributes
import List.Nonempty as Nonempty
import Svg
import Svg.Attributes as SvgAttributes


type alias ColorBandConfig =
    { colours : Scale.CalculateColor
    }


numberOfStops : Int
numberOfStops =
    102


segmentWidth : Int
segmentWidth =
    2


segmentHeight : Int
segmentHeight =
    24


padding : Int
padding =
    26


svgHeight : Float
svgHeight =
    46.0


colorYTranslate : Float
colorYTranslate =
    4.0


view : ColorBandConfig -> Html.Html msg
view config =
    let
        totalSvgWidth =
            numberOfStops * segmentWidth + padding * 2
    in
    Html.div [ HtmlAttributes.class "legend" ]
        [ Svg.svg
            [ SvgAttributes.width <| String.fromInt totalSvgWidth
            , SvgAttributes.height <| String.fromFloat svgHeight
            , SvgAttributes.fill "white"
            ]
            [ viewBody config
            ]
        ]


viewBody : ColorBandConfig -> Svg.Svg msg
viewBody config =
    Svg.g
        [ SvgAttributes.transform <| "translate(0, " ++ String.fromFloat colorYTranslate ++ ")" ]
        (viewColourBand config.colours)


viewColourBand : Scale.CalculateColor -> List (Svg.Svg msg)
viewColourBand colours =
    let
        ( _, f ) =
            case colours of
                Scale.ContinuousColor c ->
                    Chroma.domainF (Nonempty.Nonempty 0 [ toFloat numberOfStops ]) c

                Scale.DiscreteColor c ->
                    Chroma.domain (Nonempty.Nonempty 0 [ toFloat numberOfStops ]) c
    in
    viewStopColor f 0
        :: List.map (\i -> viewStopColor f i) (List.range 1 numberOfStops)


viewStopColor : (Float -> ChromaTypes.ExtColor) -> Int -> Svg.Svg msg
viewStopColor f index =
    Svg.rect
        [ SvgAttributes.x << String.fromInt <| ((index + 1) * segmentWidth + padding)
        , SvgAttributes.y "0"
        , SvgAttributes.width <| String.fromInt segmentWidth
        , SvgAttributes.height <| String.fromInt segmentHeight
        , SvgAttributes.fill (f (toFloat index) |> ChromaToHex.toHex)
        ]
        []
