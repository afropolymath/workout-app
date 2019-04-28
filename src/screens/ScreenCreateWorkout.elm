module ScreenCreateWorkout exposing (renderWorkoutCreationForm)

import AppTypes exposing (..)
import Css exposing (..)
import Css.Transitions exposing (transition)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, placeholder, src, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import SharedStyles exposing (..)


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
            [ input [ css [ fullWidthCardInputFieldStyle ], type_ "text", placeholder "Workout name...", onInput (UpdateCurrentWorkout UpdateCurrentWorkoutName) ] []
            ]
        , div [ css [ cardTableContainerStyle ] ]
            [ Html.Styled.table [ css [ width (pct 100), borderCollapse collapse ] ]
                [ thead []
                    [ tr []
                        [ th [ css [ tableHeaderStyle, width (pct 50) ] ] [ text "Exercise name" ]
                        , th [ css [ tableHeaderStyle ] ] [ text "Sets" ]
                        , th [ css [ tableHeaderStyle ] ] [ text "Reps" ]
                        , th [ css [ tableHeaderStyle ] ] [ text "Weight" ]
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
