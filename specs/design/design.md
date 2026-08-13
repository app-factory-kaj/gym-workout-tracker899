# Gym Workout Tracker — Design

A single-page React app (`workout-webapp`) lets a signed-in Athlete manage routines, log workout sessions and sets, and review progress; it calls a Ballerina API (`workout-api`) that owns all persistence in a dedicated PostgreSQL database and validates every call against Thunder-issued tokens so each Athlete only ever sees their own data.

## Context (C1)

```mermaid
graph TD
  Athlete((Athlete))
  Athlete -->|signs in, logs workouts| Webapp[Workout Tracker Webapp]
  Webapp -->|REST calls| API[Workout Tracker API]
  Webapp -->|OIDC sign-in| Thunder[Thunder Auth]
  API -->|validates token| Thunder
  API -->|reads/writes| DB[(Workout Database)]
```

## Domain model (ER)

```mermaid
erDiagram
  ATHLETE {
    string id
    string unitPreference
  }
  EXERCISE {
    string id
    string name
    boolean isCustom
  }
  ROUTINE {
    string id
    string name
  }
  ROUTINE_EXERCISE {
    string id
    string exerciseId
    int order
  }
  WORKOUT_SESSION {
    string id
    date date
    string routineId
  }
  SET_ENTRY {
    string id
    int setNumber
    int reps
    number weightKg
  }

  ATHLETE ||--o{ EXERCISE : creates
  ATHLETE ||--o{ ROUTINE : creates
  ATHLETE ||--o{ WORKOUT_SESSION : logs
  ROUTINE ||--o{ ROUTINE_EXERCISE : includes
  EXERCISE ||--o{ ROUTINE_EXERCISE : referenced_by
  ROUTINE ||--o{ WORKOUT_SESSION : "started from (optional)"
  WORKOUT_SESSION ||--o{ SET_ENTRY : contains
  EXERCISE ||--o{ SET_ENTRY : logged_as
```

## Key flows

### Sign-in

```mermaid
sequenceDiagram
  actor Athlete
  participant Webapp as Workout Tracker Webapp
  participant Thunder as Thunder Auth
  participant API as Workout Tracker API

  Athlete->>Webapp: Open app
  Webapp->>Thunder: OIDC + PKCE redirect
  Thunder-->>Webapp: ID/access token
  Webapp->>API: Request with bearer token
  API->>Thunder: Validate token
  Thunder-->>API: Token valid + claims
  API-->>Webapp: Scoped data for this Athlete
```

### Build a routine and log a session

```mermaid
sequenceDiagram
  actor Athlete
  participant Webapp as Workout Tracker Webapp
  participant API as Workout Tracker API

  Athlete->>Webapp: Create routine "Push Day"
  Webapp->>API: POST /routines (exercises list)
  API-->>Webapp: 201 Routine
  Athlete->>Webapp: Start session from routine
  Webapp->>API: POST /sessions (routineId)
  API-->>Webapp: 201 WorkoutSession
  Athlete->>Webapp: Log set (reps, weight)
  Webapp->>API: POST /sessions/{id}/sets
  API-->>Webapp: 201 SetEntry
```

### Review progress

```mermaid
sequenceDiagram
  actor Athlete
  participant Webapp as Workout Tracker Webapp
  participant API as Workout Tracker API

  Athlete->>Webapp: Open exercise progress
  Webapp->>API: GET /exercises/{id}/progress
  API-->>Webapp: Trend points + personal record
  Webapp-->>Athlete: Render chart + PR
```