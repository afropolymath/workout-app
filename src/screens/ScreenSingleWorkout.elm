module ScreenSingleWorkout exposing (renderSingleWorkout)

import AppTypes exposing (..)
import Css exposing (..)
import Css.Transitions exposing (transition)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, placeholder, src, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import SharedStyles exposing (..)


singleWorkoutTitleStyle =
    Css.batch
        [ theme.applicationFont
        , padding (px 15)
        , margin (px 0)
        , color (hex "FFF")
        , fontWeight normal
        ]


workoutDetailsStyle =
    Css.batch
        [ padding (px 15)
        , theme.applicationFont
        , color (hex "FFF")
        ]


tableFieldStyle =
    Css.batch
        [ paddingRight (px 10)
        , paddingTop (px 4)
        , paddingBottom (px 4)
        ]


renderExerciseItemRow : Int -> Exercise -> Html Msg
renderExerciseItemRow exerciseIndex exercise =
    tr []
        [ td [ css [ tableFieldStyle ] ] [ text exercise.name ]
        , td [ css [ tableFieldStyle ] ] [ text (String.fromInt exercise.sets) ]
        , td [ css [ tableFieldStyle ] ] [ text (String.fromInt exercise.reps) ]
        , td [ css [ tableFieldStyle ] ] [ text (String.fromInt exercise.weight) ]
        ]


renderSingleWorkout : WorkoutRec -> Html Msg
renderSingleWorkout workoutRec =
    div
        [ css [ applicationModuleStyle ] ]
        [ div [ css [ genericContainerStyle, cardContainerStyle, secondaryCardContainerStyle ] ]
            [ h2 [ css [ singleWorkoutTitleStyle ] ] [ text workoutRec.name ]
            , div [ css [ workoutDetailsStyle ] ]
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
            ]
        ]
