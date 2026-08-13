# Gym Workout Tracker — PRD

## Problem Statement

People who train regularly often lose track of what they actually lifted last time — which weight, how many reps, how many sets — and end up guessing at the gym instead of progressively overloading. Without a simple log tied to their own history, it's hard to tell whether they're actually getting stronger over time, and workout routines end up scribbled in notes apps or forgotten entirely.

## Solution

A private, single-user gym workout tracker where an athlete signs in, builds reusable workout routines, logs each session's exercises with sets/reps/weight against those routines, and reviews how their strength on each exercise is trending over time — so every gym visit builds on the last one instead of starting from a guess.

## Actors

- **Athlete** — the signed-in individual who creates routines, logs workout sessions and sets, sets their unit preference, and reviews their own history and progress. All data is private to this actor; there is no other role in the system.

## User Stories

1. As an Athlete, I want to sign in securely, so that my workout data is private to me and safe across visits.
2. As an Athlete, I want to create reusable workout routines made up of a chosen list of exercises, so that I can quickly start a familiar session without re-entering everything.
3. As an Athlete, I want to edit or delete a routine, so that I can adjust it as my training plan changes.
4. As an Athlete, I want to start a logged session from a routine (or start a blank session and pick exercises ad hoc), so that I can capture what I actually did that day.
5. As an Athlete, I want to record each set's reps and weight for every exercise in a session, so that I have an accurate record of what I lifted.
6. As an Athlete, I want to edit or delete a past session or set entry, so that I can correct mistakes in my log.
7. As an Athlete, I want to browse my workout history by date, so that I can review what I did on previous days.
8. As an Athlete, I want to view a strength trend for a specific exercise over time (weight, reps, and estimated one-rep-max), so that I can see whether I'm progressing.
9. As an Athlete, I want to see my personal records (heaviest weight and best estimated one-rep-max) per exercise, so that I know what I'm aiming to beat.
10. As an Athlete, I want to set my preferred weight unit (kg or lb), so that every weight I enter or view is shown in the unit I think in.
11. As an Athlete, I want to add custom exercises beyond any built-in list, so that I can log movements specific to my own training.

## Product Decisions

- Sign-in is via Thunder SSO, the platform identity provider, matching this organization's standard for every web app with sign-in.
- The tracker is single-user and purely private: each Athlete sees and manages only their own data, with no sharing, following, or trainer/coach roles.
- Exercises are organized through reusable, user-authored routines/templates rather than free-form-only logging, so recurring workouts are fast to log.
- Weight units are user-selectable per Athlete (kg or lb); all entry and display respects that preference.
- Progress is shown as per-exercise strength trends (weight, reps, estimated one-rep-max) plus personal records, not a general body-weight or body-composition tracker.
- Athletes may add their own custom exercises rather than being limited to a fixed built-in list *(assumed)*.

## Phasing

- **Phase 1 — A private, sign-in-gated workout logger with routines and per-exercise progress tracking**: deliver secure sign-in, routine creation/editing, session logging against routines or ad hoc, set-level edit/delete, history browsing, per-exercise trend and personal-record views, unit preference, and custom exercise creation. Stories: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11.

## Out of Scope

- Trainer/coach or any multi-user roles viewing another Athlete's data.
- Social or sharing features (sharing workouts, following other users, leaderboards).
- Body-weight or body-composition tracking.
- Nutrition or calorie tracking.
- Wearable device or third-party fitness app integration/sync.

## Open Questions

None — all decisions needed to proceed to design were resolved above.

## Further Notes

None.