module SharedStyles exposing (applicationModuleStyle, cardContainerStyle, defaultButtonStyle, flexContainer, fullWidthInputFieldStyle, genericContainerStyle, secondaryCardContainerStyle, tableHeaderStyle, theme)

import Css exposing (..)
import Css.Transitions exposing (transition)


theme =
    { headerBackground = hex "2F2F2F"
    , applicationBackground = hex "242424"
    , cardFooterBackground = hex "D5D5D5"
    , lightBackground = hex "EBEBEB"
    , applicationFont = fontFamilies [ "Avenir Next", "Arial", "sans-serif" ]
    , secondaryColor = hex "FF4800"
    , secondaryColorHover = hex "E14001"
    , headerHeight = px 60
    , applicationGutter = px 20
    , lightBorderColor = hex "848484"
    , lighterBorderColor = hex "D2D2D2"
    , darkBorderColor = hex "464646"
    , cardContentPadding = px 10
    , looseCardContentPadding = px 15
    , containerWidth = px 1024
    , cardBackgroundColor = hex "4D4D4D"
    , cardTextColor = hex "DDD"
    , cardHoverBorderColor = hex "C1C1C1"
    , applicationShadows = boxShadow5 (px 1) (px 5) (px 7) (px 0) (rgba 0 0 0 0.3)
    , applicationContentPaddingVertical = px 20
    , applicationContentPaddingHorizontal = px 20
    , applicationBorderRadius = px 4
    }


fullWidthInputFieldStyle =
    Css.batch
        [ display block
        , backgroundColor transparent
        , theme.applicationFont
        , width (pct 100)
        , border3 (px 0) solid transparent
        , boxSizing borderBox
        , focus
            [ outline none
            ]
        ]


defaultButtonStyle : Style
defaultButtonStyle =
    Css.batch
        [ backgroundColor theme.secondaryColor
        , theme.applicationFont
        , fontSize (Css.em 1.0)
        , color (hex "FFFF")
        , padding2 (px 7) (px 12)
        , border3 (px 0) solid transparent
        , cursor pointer
        , hover
            [ backgroundColor theme.secondaryColorHover
            ]
        , focus
            [ outline none
            ]
        , transition
            [ Css.Transitions.backgroundColor 1000
            ]
        ]


applicationModuleStyle : Style
applicationModuleStyle =
    Css.batch
        [ position absolute
        , top theme.headerHeight
        , bottom (px 0)
        , left (px 0)
        , right (px 0)
        , padding theme.applicationGutter
        ]


genericContainerStyle =
    Css.batch
        [ width (pct 100)
        , maxWidth theme.containerWidth
        , margin2 (px 0) auto
        ]


cardContainerStyle =
    Css.batch
        [ backgroundColor theme.lightBackground
        , position relative
        , height (pct 100)
        ]


secondaryCardContainerStyle =
    Css.batch
        [ backgroundColor theme.secondaryColor
        , theme.applicationShadows
        ]


tableHeaderStyle =
    Css.batch
        [ padding2 (px 7) (px 0)
        , theme.applicationFont
        , fontSize (Css.em 1)
        , textAlign left
        ]


flexContainer : Style
flexContainer =
    Css.batch
        [ displayFlex
        , alignItems center
        ]
