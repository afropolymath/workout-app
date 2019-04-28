module State exposing (init, subscriptions, updateWithStorage)

import AppTypes exposing (..)
import Ports exposing (..)


init : Maybe (List WorkoutRec) -> ( Model, Cmd Msg )
init flags =
    let
        workouts =
            case flags of
                Just cachedWorkouts ->
                    cachedWorkouts

                Nothing ->
                    []
    in
    ( Model workouts NoWorkoutSelected, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


updateWithStorage : Msg -> Model -> ( Model, Cmd Msg )
updateWithStorage msg model =
    let
        ( newModel, commands ) =
            update msg model

        workouts =
            newModel.workouts
    in
    ( newModel, Cmd.batch [ commands, cacheWorkouts workouts ] )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DisplayAll ->
            ( { model | currentWorkout = NoWorkoutSelected }, Cmd.none )

        DisplayOne workoutRec ->
            ( { model | currentWorkout = CreatedWorkout workoutRec }, Cmd.none )

        CreateWorkout ->
            ( { model | currentWorkout = emptyWorkout }, Cmd.none )

        UpdateCurrentWorkout updateAction fieldValue ->
            ( { model | currentWorkout = updateWorkout model.currentWorkout updateAction fieldValue }, Cmd.none )

        SaveWorkout workoutRec ->
            ( { model | workouts = addWorkout workoutRec model.workouts, currentWorkout = NoWorkoutSelected }, Cmd.none )

        ToggleWorkoutListItem itemIndex ->
            ( { model | workouts = toggleWorkout itemIndex model.workouts }, Cmd.none )


toggleWorkout : Int -> List WorkoutRec -> List WorkoutRec
toggleWorkout workoutIndex workoutList =
    let
        toggleItem index item =
            if index == workoutIndex then
                { item | isOpen = not item.isOpen }

            else
                item
    in
    List.indexedMap toggleItem workoutList


emptyExercise : Exercise
emptyExercise =
    Exercise "" "" 0 0 0 "kg" True True


emptyWorkout : Workout
emptyWorkout =
    NewWorkout (WorkoutRec "" [ emptyExercise ] False)


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
                    exercises ++ [ emptyExercise ]

                1 ->
                    exercises

                2 ->
                    nonEmptyExercises ++ [ emptyExercise ]

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
