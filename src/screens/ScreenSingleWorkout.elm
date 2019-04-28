module ScreenSingleWorkout exposing (renderSingleWorkout)

import AppTypes exposing (..)
import Css exposing (..)
import Css.Global exposing (descendants, typeSelector)
import Css.Transitions exposing (transition)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, href, placeholder, src, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import SharedStyles exposing (..)


workoutTitleStyle =
    Css.batch
        [ displayFlex
        , alignItems center
        , padding2 (px 15) theme.applicationContentPaddingHorizontal
        , borderBottom3 (px 1) solid (hex "FF895B")
        ]


workoutTitleTextStyle =
    Css.batch
        [ theme.applicationFont
        , flexGrow (num 1)
        , margin (px 0)
        , color (hex "FFF")
        , fontWeight normal
        ]


workoutDetailsStyle =
    Css.batch
        [ padding2 (px 15) theme.applicationContentPaddingHorizontal
        , theme.applicationFont
        , color (hex "FFF")
        ]


tableFieldStyle =
    Css.batch
        [ paddingRight (px 10)
        , paddingTop (px 7)
        , paddingBottom (px 7)
        ]


iconLinkStyle =
    Css.batch
        [ display inlineBlock
        , width (px 30)
        , height (px 24)
        , color (hex "FFF")
        , cursor pointer
        , marginRight (px 8)
        ]


outlineLinkStyle =
    Css.batch
        [ display inlineFlex
        , color (hex "FFF")
        , theme.applicationFont
        , alignItems center
        , border3 (px 1) solid (hex "FFF")
        , borderRadius theme.applicationBorderRadius
        , padding2 (px 6) (px 8)
        , descendants
            [ typeSelector "span"
                [ marginLeft (px 10) ]
            , typeSelector "i" [ fontSize (px 20) ]
            ]
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
            [ div [ css [ workoutTitleStyle ] ]
                [ a [ css [ iconLinkStyle ], onClick DisplayAll ]
                    [ i [ class "material-icons" ] [ text "arrow_back" ]
                    ]
                , h2 [ css [ workoutTitleTextStyle ] ] [ text workoutRec.name ]
                , a [ css [ outlineLinkStyle ] ]
                    [ i [ class "material-icons " ] [ text "edit" ]
                    , span [] [ text "Edit workout" ]
                    ]
                ]
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
