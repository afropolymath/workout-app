module Main exposing (main)

import Browser
import ScreenMain exposing (view)
import State exposing (init, subscriptions, update)


main =
    Browser.element { init = init, update = update, subscriptions = subscriptions, view = view }
