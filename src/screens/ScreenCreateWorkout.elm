module ScreenCreateWorkout exposing (renderWorkoutCreationForm)

import AppTypes exposing (..)
import Css exposing (..)
import Css.Transitions exposing (transition)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, placeholder, src, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import SharedStyles exposing (..)


cardContainerStyle =
    Css.batch
        [ backgroundColor theme.lightBackground
        , position absolute
        , left (px 0)
        , right (px 0)
        , bottom theme.applicationGutter
        , top theme.applicationGutter
        ]


fullWidthCardInputFieldStyle =
    Css.batch
        [ fullWidthInputFieldStyle
        , padding2 (px 15) (px 20)
        , fontSize (Css.em 1.4)
        , borderBottom3 (px 1) solid theme.lighterBorderColor
        , focus
            [ outline none
            , borderColor theme.secondaryColor
            ]
        ]


cardTableContainerStyle =
    Css.batch
        [ padding (px 15)
        ]


cardFooterStyle =
    Css.batch
        [ backgroundColor theme.cardFooterBackground
        , position absolute
        , left (px 0)
        , right (px 0)
        , bottom (px 0)
        , padding theme.applicationGutter
        ]


exerciseTableHeaderStyle =
    Css.batch
        [ padding2 (px 7) (px 0)
        , theme.applicationFont
        , fontSize (Css.em 1)
        , textAlign left
        ]


exerciseTableFieldStyle =
    Css.batch
        [ borderBottom3 (px 1) solid theme.lighterBorderColor
        ]


exerciseTableFieldInputStyle =
    Css.batch
        [ fullWidthInputFieldStyle
        , padding2 (px 4) (px 0)
        , fontSize (Css.em 1)
        ]


renderExerciseItemRow : Int -> Exercise -> Html Msg
renderExerciseItemRow exerciseIndex exercise =
    tr []
        [ td [ css [ exerciseTableFieldStyle ] ]
            [ input [ css [ exerciseTableFieldInputStyle ], type_ "text", placeholder "Enter exercise name", value exercise.name, onInput (UpdateCurrentWorkout (UpdateCurrentWorkoutExercise exerciseIndex "name")) ] []
            ]
        , td [ css [ exerciseTableFieldStyle ] ]
            [ input [ css [ exerciseTableFieldInputStyle ], type_ "number", placeholder "0", value (String.fromInt exercise.sets), onInput (UpdateCurrentWorkout (UpdateCurrentWorkoutExercise exerciseIndex "sets")) ] []
            ]
        , td [ css [ exerciseTableFieldStyle ] ]
            [ input [ css [ exerciseTableFieldInputStyle ], type_ "number", placeholder "0", value (String.fromInt exercise.reps), onInput (UpdateCurrentWorkout (UpdateCurrentWorkoutExercise exerciseIndex "reps")) ] []
            ]
        , td [ css [ exerciseTableFieldStyle ] ]
            [ input [ css [ exerciseTableFieldInputStyle ], type_ "number", placeholder "0", value (String.fromInt exercise.weight), onInput (UpdateCurrentWorkout (UpdateCurrentWorkoutExercise exerciseIndex "weight")) ] []
            ]
        ]


renderWorkoutCreationForm : WorkoutRec -> Html Msg
renderWorkoutCreationForm workoutRec =
    [ div [ css [ genericContainerStyle, cardContainerStyle ] ]
        [ div []
            [ input [ css [ fullWidthCardInputFieldStyle ], type_ "text", placeholder "Workout name..." ] []
            ]
        , div [ css [ cardTableContainerStyle ] ]
            [ Html.Styled.table [ css [ width (pct 100), borderCollapse collapse ] ]
                [ thead []
                    [ tr []
                        [ th [ css [ exerciseTableHeaderStyle, width (pct 50) ] ] [ text "Exercise name" ]
                        , th [ css [ exerciseTableHeaderStyle ] ] [ text "Reps" ]
                        , th [ css [ exerciseTableHeaderStyle ] ] [ text "Sets" ]
                        , th [ css [ exerciseTableHeaderStyle ] ] [ text "Weight" ]
                        ]
                    ]
                , tbody [] (List.indexedMap renderExerciseItemRow workoutRec.exercises)
                ]
            ]
        , div [ css [ cardFooterStyle ] ]
            [ button [ css [ defaultButtonStyle ], onClick (SaveWorkout workoutRec) ] [ text "Save workout" ]
            ]
        ]
    ]
        |> div [ css [ applicationModuleStyle ] ]
