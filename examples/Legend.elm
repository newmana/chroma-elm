module Legend exposing (ContinuousLegendConfig, view)

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


type alias ContinuousLegendConfig =
    { ticks : Nonempty.Nonempty Float
    , colours : Scale.CalculateColor
    }


numberOfStops : Int
numberOfStops =
    102


segmentWidth : Int
segmentWidth =
    2


padding : Int
padding =
    26


svgHeight : Float
svgHeight =
    46.0


unitsYTranslate : Float
unitsYTranslate =
    34.0


textTopPadding : Int
textTopPadding =
    14


segmentHeight : Int
segmentHeight =
    24


colorYTranslate : Float
colorYTranslate =
    4.0


tickWidth : Int
tickWidth =
    1


view : ContinuousLegendConfig -> Html.Html msg
view config =
    let
        -- 4 pixels wide * 102 -> 408
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


viewBody : ContinuousLegendConfig -> Svg.Svg msg
viewBody config =
    Svg.g
        [ SvgAttributes.transform <| "translate(0, " ++ String.fromFloat colorYTranslate ++ ")" ]
        (viewColourBand config.colours
            ++ viewTicks config
        )


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


viewTicks : ContinuousLegendConfig -> List (Svg.Svg msg)
viewTicks config =
    let
        numberOfTicks =
            List.length ticks

        tickPosition index =
            toFloat numberOfStops * toFloat index / toFloat numberOfTicks

        reverseTicks =
            config.ticks |> Nonempty.reverse

        ticks =
            reverseTicks |> Nonempty.tail |> List.reverse

        max =
            reverseTicks |> Nonempty.head
    in
    List.indexedMap (\index tick -> viewTick (tickPosition index) tick) ticks
        ++ [ viewLabel numberOfStops max ]


viewTick : Float -> Float -> Svg.Svg msg
viewTick position floatLabel =
    Svg.g []
        [ Svg.rect
            [ (SvgAttributes.x << String.fromFloat) <|
                ((position + 1) * toFloat segmentWidth + toFloat padding)
            , SvgAttributes.y "0"
            , SvgAttributes.width <| String.fromInt tickWidth
            , SvgAttributes.height <| String.fromInt segmentHeight
            , SvgAttributes.fill "white"
            ]
            []
        , viewLabel (floor position) floatLabel
        ]


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


viewLabel : Int -> Float -> Svg.Svg msg
viewLabel index floatLabel =
    Svg.text_
        [ SvgAttributes.x << String.fromInt <| (index + 1) * segmentWidth + padding
        , SvgAttributes.y << String.fromInt <| segmentHeight + textTopPadding
        , SvgAttributes.textAnchor "middle"
        , SvgAttributes.fill "black"
        ]
        [ Svg.text (String.fromFloat floatLabel) ]


viewTextElement : String -> Float -> Svg.Svg msg
viewTextElement string y =
    Svg.text_
        [ SvgAttributes.x "50%"
        , SvgAttributes.y <| String.fromFloat y
        , SvgAttributes.textAnchor "middle"
        , SvgAttributes.fill "black"
        ]
        [ Svg.text string ]
