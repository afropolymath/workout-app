module State exposing (init, subscriptions, update)

import AppTypes exposing (..)


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model [] NoWorkoutSelected, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DisplayAll ->
            ( { model | currentWorkout = NoWorkoutSelected }, Cmd.none )

        DisplayOne workout ->
            ( { model | currentWorkout = workout }, Cmd.none )

        CreateWorkout ->
            ( { model | currentWorkout = emptyWorkout }, Cmd.none )

        UpdateCurrentWorkout updateAction fieldValue ->
            ( { model | currentWorkout = updateWorkout model.currentWorkout updateAction fieldValue }, Cmd.none )

        SaveWorkout workoutRec ->
            ( { model | workouts = addWorkout workoutRec model.workouts, currentWorkout = NoWorkoutSelected }, Cmd.none )


emptyWorkout : Workout
emptyWorkout =
    NewWorkout (WorkoutRec "" [ Exercise "" "" 0 0 0 "kg" True True ])


spliceAt : Int -> List Exercise -> List Exercise
spliceAt index list =
    let
        listHead =
            if index > 0 then
                List.drop index list

            else
                []

        listTail =
            if index < List.length list then
                List.drop (index + 1) list

            else
                []
    in
    listHead ++ listTail


addWorkout : WorkoutRec -> List WorkoutRec -> List WorkoutRec
addWorkout workoutRec workoutsList =
    workoutsList ++ [ workoutRec ]


updateWorkout : Workout -> UpdateCurrentWorkoutAction -> String -> Workout
updateWorkout currentWorkout updateAction fieldValue =
    let
        filterEmpty exercises =
            let
                filteredList =
                    List.filter (\ex -> not ex.isEmpty || ex.isPristine) exercises

                nonEmptyExercises =
                    List.filter (\ex -> not ex.isEmpty) exercises
            in
            case List.length exercises - List.length nonEmptyExercises of
                0 ->
                    exercises ++ [ Exercise "" "" 0 0 0 "kg" True True ]

                1 ->
                    exercises

                2 ->
                    nonEmptyExercises ++ [ Exercise "" "" 0 0 0 "kg" True True ]

                _ ->
                    filteredList

        updateExerciseAtIndex exerciseIndex fieldName index exercise =
            let
                updatedFields =
                    case fieldName of
                        "name" ->
                            { exercise | name = fieldValue }

                        "sets" ->
                            { exercise | sets = Maybe.withDefault 0 (String.toInt fieldValue) }

                        "reps" ->
                            { exercise | reps = Maybe.withDefault 0 (String.toInt fieldValue) }

                        "weight" ->
                            { exercise | weight = Maybe.withDefault 0 (String.toInt fieldValue) }

                        _ ->
                            exercise

                rowIsEmpty =
                    updatedFields.name == "" && updatedFields.reps == 0 && updatedFields.sets == 0 && updatedFields.weight == 0
            in
            if index == exerciseIndex then
                { updatedFields | isPristine = False, isEmpty = rowIsEmpty }

            else
                exercise

        updateWorkoutField workoutRec =
            case updateAction of
                UpdateCurrentWorkoutName ->
                    { workoutRec | name = fieldValue }

                UpdateCurrentWorkoutExercise exerciseIndex fieldName ->
                    { workoutRec | exercises = filterEmpty (List.indexedMap (updateExerciseAtIndex exerciseIndex fieldName) workoutRec.exercises) }
    in
    case currentWorkout of
        CreatedWorkout workoutRec ->
            CreatedWorkout (updateWorkoutField workoutRec)

        NewWorkout workoutRec ->
            NewWorkout (updateWorkoutField workoutRec)

        NoWorkoutSelected ->
            NoWorkoutSelected
