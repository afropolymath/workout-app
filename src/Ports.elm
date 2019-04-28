port module Ports exposing (cacheWorkouts)

import AppTypes exposing (..)


port cacheWorkouts : List WorkoutRec -> Cmd msg
