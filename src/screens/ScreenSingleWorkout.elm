module ScreenSingleWorkout exposing (renderSingleWorkout)

import AppTypes exposing (..)
import Css exposing (..)
import Css.Transitions exposing (transition)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, placeholder, src, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import SharedStyles exposing (..)


renderSingleWorkout : WorkoutRec -> Html Msg
renderSingleWorkout workoutRec =
    div [] [ text "Single workout" ]
