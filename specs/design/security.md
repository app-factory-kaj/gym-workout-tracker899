# Security design

## Roles → permissions

There is no admin, trainer, or shared-visibility role: the PRD defines a single Actor, and every record is owned and viewable only by the Athlete who created it.

## Authentication (Thunder)

- Shared `thunder-app` dependency name: `workout-auth`, declared identically on `workout-webapp` and `workout-api`.
- Scopes: `openid profile email` (default).
- `workout-webapp` is the sign-in side: it runs the OIDC + PKCE flow and attaches the resulting bearer token to every `workout-api` call.
- `workout-api` is the protected side: it validates the bearer token on every request and rejects unauthenticated calls with `401`.

## Role resolution

`workout-api` derives the caller's identity from the validated token's subject claim, injected by the gateway as `X-User-Id`. Every record (exercise, routine, session, set) is scoped by that identifier at creation and on every subsequent read/write; a request whose token does not resolve to a known Athlete is rejected with `401`, and a request for a record owned by a different Athlete id is rejected with `404` (never revealing existence to a non-owner). There are no additional group/role claims to check — every authenticated caller is an Athlete acting on their own data.