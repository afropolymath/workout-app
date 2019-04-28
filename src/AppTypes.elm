module AppTypes exposing (Exercise, Model, Msg(..), UpdateCurrentWorkoutAction(..), Workout(..), WorkoutRec)


type alias Exercise =
    { name : String
    , ref : String
    , sets : Int
    , reps : Int
    , weight : Int
    , weightUnit : String
    , isEmpty : Bool
    , isPristine : Bool
    }


type alias WorkoutRec =
    { name : String
    , exercises : List Exercise
    , isOpen : Bool
    }


type Workout
    = CreatedWorkout WorkoutRec
    | NewWorkout WorkoutRec
    | NoWorkoutSelected


type UpdateCurrentWorkoutAction
    = UpdateCurrentWorkoutName
    | UpdateCurrentWorkoutExercise Int String


type Msg
    = DisplayAll
    | DisplayOne WorkoutRec
    | CreateWorkout
    | UpdateCurrentWorkout UpdateCurrentWorkoutAction String
    | SaveWorkout WorkoutRec
    | ToggleWorkoutListItem Int


type alias Model =
    { workouts : List WorkoutRec
    , currentWorkout : Workout
    }
