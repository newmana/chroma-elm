module ReviewConfig exposing (config)

{-| Do not rename the ReviewConfig module or the config function, because
`elm-review` will look for these.

To add packages that contain rules, add them to this review project using

    `elm install author/packagename`

when inside the directory containing this file.

-}

import NoDeprecated
import NoExposingEverything
import NoImportingEverything
import NoMissingTypeAnnotation
import NoMissingTypeExpose
import NoPrematureLetComputation
import NoUnused.CustomTypeConstructorArgs
import NoUnused.CustomTypeConstructors
import NoUnused.Dependencies
import NoUnused.Exports
import NoUnused.Modules
import NoUnused.Parameters
import NoUnused.Patterns
import NoUnused.Variables
import Review.Rule exposing (Rule)
import Simplify


config : List Review.Rule.Rule
config =
    let
        noUnused =
            [ NoUnused.CustomTypeConstructors.rule []
            , NoUnused.CustomTypeConstructorArgs.rule
            , NoUnused.Dependencies.rule
            , NoUnused.Exports.rule
            , NoUnused.Modules.rule
            , NoUnused.Parameters.rule
            , NoUnused.Patterns.rule
            , NoUnused.Variables.rule
            ]

        noCommon =
            [ NoExposingEverything.rule
            , NoDeprecated.rule NoDeprecated.defaults
            , NoImportingEverything.rule []
            , NoMissingTypeAnnotation.rule

            --, NoMissingTypeAnnotationInLetIn.rule
            , NoMissingTypeExpose.rule
            , NoPrematureLetComputation.rule
            ]
    in
    noUnused ++ noCommon ++ [ Simplify.rule Simplify.defaults ]
