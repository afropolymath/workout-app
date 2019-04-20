module ScreenWorkoutListing exposing (renderWorkoutList)

import AppTypes exposing (..)
import Css exposing (..)
import Css.Transitions exposing (transition)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, placeholder, src, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import SharedStyles exposing (..)


workoutListItem =
    Css.batch
        [ padding2 (px 0) theme.cardContentPadding
        , border3 (px 1) solid theme.lightBorderColor
        ]


workoutListItemHeader =
    Css.batch
        [ height (px 35)
        , theme.applicationFont
        , displayFlex
        , alignItems center
        , borderBottom3 (px 1) solid theme.darkBorderColor
        ]


workoutListItemTitle =
    Css.batch
        [ lineHeight (px 35)
        , fontSize (Css.em 1)
        , flexGrow (num 1)
        , before
            [ property "content" "''"
            , position absolute
            , left (px 0)
            , top (px 0)
            , bottom (px 0)
            , margin2 (px 0) auto
            , width (px 10)
            , height (px 10)
            , borderRight3 (px 2) solid (hex "FFF")
            , borderBottom3 (px 2) solid (hex "FFF")
            , transform (rotate (deg 45))
            ]
        ]


workoutListItemLink =
    Css.batch
        [ color theme.secondaryColor
        , fontSize (Css.em 1)
        ]


workoutListItemMetricsTable =
    Css.batch
        [ margin2 (px 10) (px 0)
        ]


renderWorkoutListItem : WorkoutRec -> Html Msg
renderWorkoutListItem workoutRec =
    div [ css [ workoutListItem ] ]
        [ div [ css [ workoutListItemHeader ] ]
            [ h2 [ css [ workoutListItemTitle ] ] [ text workoutRec.name ]
            , a [ css [ workoutListItemLink ] ] [ text "View workout" ]
            ]
        , Html.Styled.table [ css [ workoutListItemMetricsTable ] ]
            [ tbody []
                [ tr []
                    [ th [] [ text "Metric 1" ]
                    , td [] [ text "Metric 1" ]
                    , th [] [ text "Metric 1" ]
                    , td [] [ text "Metric 1" ]
                    ]
                , tr []
                    [ th [] [ text "Metric 1" ]
                    , td [] [ text "Metric 1" ]
                    , th [] [ text "Metric 1" ]
                    , td [] [ text "Metric 1" ]
                    ]
                , tr []
                    [ th [] [ text "Metric 1" ]
                    , td [] [ text "Metric 1" ]
                    , th [] [ text "Metric 1" ]
                    , td [] [ text "Metric 1" ]
                    ]
                , tr []
                    [ th [] [ text "Metric 1" ]
                    , td [] [ text "Metric 1" ]
                    , th [] [ text "Metric 1" ]
                    , td [] [ text "Metric 1" ]
                    ]
                ]
            ]
        ]


renderWorkoutList : List WorkoutRec -> Html Msg
renderWorkoutList workoutList =
    let
        displayContent =
            if List.length workoutList > 0 then
                List.map renderWorkoutListItem workoutList

            else
                [ p [] [ text "There are no workouts here yet" ] ]
    in
    div [ css [ applicationModuleStyle ] ]
        [ div [ css [ genericContainerStyle ] ] displayContent
        ]
