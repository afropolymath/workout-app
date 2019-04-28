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
        [ backgroundColor theme.cardBackgroundColor
        , padding2 (px 0) theme.looseCardContentPadding
        , border3 (px 1) solid theme.lightBorderColor
        , marginBottom (px 17)
        , hover
            [ borderColor theme.cardHoverBorderColor
            , theme.applicationShadows
            ]
        ]


workoutListItemHeader =
    Css.batch
        [ height (px 42)
        , theme.applicationFont
        , displayFlex
        , alignItems center
        , borderBottom3 (px 1) solid theme.darkBorderColor
        , cursor pointer
        ]


workoutListItemTitle : Bool -> Style
workoutListItemTitle isOpen =
    Css.batch
        [ position relative
        , lineHeight (px 42)
        , fontSize (Css.em 1)
        , flexGrow (num 1)
        , paddingLeft (px 36)
        , color (hex "FFF")
        , before
            [ property "content" "''"
            , position absolute
            , left (px 8)
            , if isOpen then
                top (px -5)

              else
                top (px 3)
            , bottom (px 0)
            , margin2 auto (px 0)
            , width (px 10)
            , height (px 10)
            , borderRight3 (px 2) solid (hex "FFF")
            , borderBottom3 (px 2) solid (hex "FFF")
            , if isOpen then
                transform (rotate (deg 45))

              else
                transform (rotate (deg 225))
            ]
        ]


workoutListItemLink =
    Css.batch
        [ color theme.secondaryColor
        , fontSize (Css.em 0.9)
        , padding (px 5)
        ]


workoutListItemMetricsTable isOpen =
    Css.batch
        [ margin2 (px 10) (px 0)
        , theme.applicationFont
        , color theme.cardTextColor
        , if isOpen then
            display Css.table

          else
            display none
        ]


workoutListItemMetricsTableHeader =
    Css.batch
        [ width (pct 1)
        , whiteSpace noWrap
        , textAlign left
        , paddingRight (px 20)
        ]


renderWorkoutList : List WorkoutRec -> Html Msg
renderWorkoutList workoutList =
    let
        displayContent =
            if List.length workoutList > 0 then
                List.indexedMap renderWorkoutListItem workoutList

            else
                [ p [] [ text "There are no workouts here yet" ] ]
    in
    div [ css [ applicationModuleStyle ] ]
        [ div [ css [ genericContainerStyle ] ] displayContent
        ]


renderWorkoutListItem : Int -> WorkoutRec -> Html Msg
renderWorkoutListItem workoutItemIndex workoutRec =
    let
        totalExercises =
            List.length workoutRec.exercises

        totalReps =
            List.foldr (+) 0 (List.map (\ex -> ex.reps * ex.sets) workoutRec.exercises)
    in
    div [ css [ workoutListItem ] ]
        [ div [ css [ workoutListItemHeader ], onClick (ToggleWorkoutListItem workoutItemIndex) ]
            [ h2 [ css [ workoutListItemTitle workoutRec.isOpen ] ] [ text workoutRec.name ]
            , a [ css [ workoutListItemLink ], onClick (DisplayOne workoutRec) ] [ text "View workout" ]
            ]
        , Html.Styled.table [ css [ workoutListItemMetricsTable workoutRec.isOpen ] ]
            [ tbody []
                [ tr [] (renderMetric "Exercises" (String.fromInt totalExercises) ++ renderMetric "Times completed" "Metric 2 value")
                , tr [] (renderMetric "Total Reps" (String.fromInt totalReps) ++ renderMetric "Success rate" "Metric 2 value")
                , tr [] (renderMetric "Estimated time" "-")
                ]
            ]
        ]


renderMetric : String -> String -> List (Html Msg)
renderMetric metricName metricValue =
    [ th [ css [ workoutListItemMetricsTableHeader ] ] [ text metricName ]
    , td [] [ text metricValue ]
    ]
