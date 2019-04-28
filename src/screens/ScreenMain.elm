module ScreenMain exposing (view)

import AppTypes exposing (..)
import Css exposing (..)
import Css.Transitions exposing (transition)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, placeholder, src, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import ScreenCreateWorkout exposing (renderWorkoutCreationForm)
import ScreenSingleWorkout exposing (renderSingleWorkout)
import ScreenWorkoutListing exposing (renderWorkoutList)
import SharedStyles exposing (..)


fullScreenContainerMixin : List Style
fullScreenContainerMixin =
    [ position absolute
    , top (px 0)
    , bottom (px 0)
    , left (px 0)
    , right (px 0)
    ]


applicationContainerStyle : Style
applicationContainerStyle =
    [ backgroundColor theme.applicationBackground
    , height (pct 100)
    ]
        ++ fullScreenContainerMixin
        |> Css.batch


headerStyle : Style
headerStyle =
    Css.batch
        [ backgroundColor theme.headerBackground
        , height theme.headerHeight
        , padding2 (px 0) theme.applicationGutter
        ]


headerTextStyle : Style
headerTextStyle =
    Css.batch
        [ color (hex "FFF")
        , flexGrow (num 1)
        , theme.applicationFont
        , fontSize (Css.em 1.5)
        , fontWeight normal
        , margin (px 0)
        , lineHeight theme.headerHeight
        ]


renderApplicationHeader : Html Msg
renderApplicationHeader =
    div [ css [ headerStyle ] ]
        [ div [ css [ genericContainerStyle, flexContainer ] ]
            [ h1 [ css [ headerTextStyle ] ] [ text "Workout Zeug" ]
            , button [ css [ defaultButtonStyle ], onClick CreateWorkout ] [ text "Create workout" ]
            ]
        ]


view : Model -> Html.Html Msg
view model =
    div [ css [ applicationContainerStyle ] ]
        [ renderApplicationHeader
        , case model.currentWorkout of
            CreatedWorkout workoutRec ->
                renderSingleWorkout workoutRec

            NewWorkout workoutRec ->
                renderWorkoutCreationForm workoutRec

            NoWorkoutSelected ->
                renderWorkoutList model.workouts
        ]
        |> toUnstyled
