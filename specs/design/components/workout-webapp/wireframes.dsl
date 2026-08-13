// Gym Workout Tracker — single-role (Athlete) webapp

screen Dashboard "Athlete lands here after sign-in and sees recent activity"
  navbar "WorkoutTracker"
  sidebar "Dashboard -> Dashboard | Routines -> Routines | History -> History | Progress -> ExerciseProgress | Settings -> Settings"
  row
    heading "Welcome back"
    right
    button "Start session" primary -> LogSession
  row
    card "Sessions this week | 4 | up from 3 last week"
    card "Current routines | 3 | Push / Pull / Legs"
    card "Personal records | 12 | across all exercises"
  heading "Recent sessions"
  table "Date | Routine | Exercises | Sets logged" -> History
    row "Aug 12 | Push Day | 4 | 14"
    row "Aug 10 | Pull Day | 3 | 12"
    row "Aug 8 | Legs | 5 | 18"

screen Routines "Athlete browses and manages reusable workout routines"
  navbar "WorkoutTracker"
  sidebar "Dashboard -> Dashboard | Routines -> Routines | History -> History | Progress -> ExerciseProgress | Settings -> Settings"
  row
    heading "Routines"
    right
    button "New routine" primary -> RoutineEditor
  table "Routine | Exercises | Last used" -> RoutineEditor
    row "Push Day | Bench Press, Overhead Press, Dips | Aug 12"
    row "Pull Day | Deadlift, Rows, Pull-ups | Aug 10"
    row "Legs | Squat, Lunges, Leg Press | Aug 8"

screen RoutineEditor "Athlete creates or edits a routine's exercise list"
  navbar "WorkoutTracker"
  sidebar "Dashboard -> Dashboard | Routines -> Routines | History -> History | Progress -> ExerciseProgress | Settings -> Settings"
  breadcrumb "Routines / Push Day"
  input "Routine name — e.g. Push Day"
  heading "Exercises"
  table "Order | Exercise | Remove"
    row "1 | Bench Press | Remove"
    row "2 | Overhead Press | Remove"
    row "3 | Dips | Remove"
  select "Add exercise: Triceps Pushdown"
  row
    right
    button "Cancel" -> Routines
    button "Save routine" primary -> Routines

screen LogSession "Athlete logs sets for each exercise in the active session"
  navbar "WorkoutTracker"
  sidebar "Dashboard -> Dashboard | Routines -> Routines | History -> History | Progress -> ExerciseProgress | Settings -> Settings"
  row
    heading "Push Day — Aug 13"
    right
    badge "In progress" info
  card "Bench Press"
    table "Set | Reps | Weight (kg)"
      row "1 | 8 | 60"
      row "2 | 8 | 60"
      row "3 | 6 | 65"
    row
      input "Reps"
      input "Weight (kg)"
      button "Add set" primary
  card "Overhead Press"
    table "Set | Reps | Weight (kg)"
      row "1 | 10 | 30"
    row
      input "Reps"
      input "Weight (kg)"
      button "Add set" primary
  row
    right
    button "Finish session" primary -> Dashboard

screen History "Athlete browses past sessions by date"
  navbar "WorkoutTracker"
  sidebar "Dashboard -> Dashboard | Routines -> Routines | History -> History | Progress -> ExerciseProgress | Settings -> Settings"
  row
    heading "Workout History"
    right
    search "Search by routine or exercise"
  table "Date | Routine | Exercises | Sets logged" -> LogSession
    row "Aug 12 | Push Day | 4 | 14"
    row "Aug 10 | Pull Day | 3 | 12"
    row "Aug 8 | Legs | 5 | 18"
    row "Aug 5 | Push Day | 4 | 13"

screen ExerciseProgress "Athlete reviews a strength trend and personal record for one exercise"
  navbar "WorkoutTracker"
