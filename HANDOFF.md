# Handoff

Running log for the MNSTR v2 app, newest first.

## 2026-11-26: Battles over gRPC instead of WebSockets (branch `battle`)

What changed (commits `17a350a`, `920fd8e`):

- `proto/` points at [mnstrv2proto `battle`](https://github.com/mnstrapp/mnstrv2proto/tree/battle) (`9ff669e`).
  Dart protos in `lib/proto/` were regenerated with
  `protoc -Iproto --dart_out=grpc:lib/proto proto/*.proto` (protoc_plugin 25.1.0, so `protobuf: ^6.1.0` is now
  a direct dependency). `wallets.pbgrpc.dart` and `transactions.pbgrpc.dart` are gone because those protos no
  longer have services.
- `lib/providers/battle.dart`: `BattleClient` (via `battleClientProvider`) owns one `ClientChannel` with HTTP/2
  keepalive. `connect()` opens the `Join` event stream and reconnects after 1, 2, 5, then every 10 seconds when
  it drops; `UNAUTHENTICATED` stops it. `disconnect()` closes the stream, which the server treats as leaving
  the lobby. Unary calls (`leave`, `listPlayers`, `challenge`, `cancelChallenge`, `acceptChallenge`,
  `rejectChallenge`, `chooseMnstr`, `attack`, `defend`, `magic`, `escape`, `rejoin`) send the session token and
  throw `BattleException` (`kind` plus a message safe to show).
- `lib/battle/layout.dart`, `queue.dart`, `vs.dart` now use `BattleEvent` / `BattleState`. The 1-second ping
  is gone. After a reconnect during a battle the app calls `Rejoin`. The vs screen sorts mnstrs on the
  client. It also has a "Run away" button while waiting for the opponent to choose.
- `lib/battle/battle_state.dart` (lobby, challenge, turn and reward mapping, client-side sort) replaces
  `data.dart`, `game_data.dart` and `battle_status.dart`.
- Removed `web_socket_channel`, `wsHost` / `wsUrl` and the unused `lib/utils/graphql.dart`.
- `17a350a` is what `flutter pub get` on Flutter 3.50 writes: analyzer excludes in `analysis_options.yaml`
  and the Windows plugin order.

Checks run: `dart analyze` (no errors or warnings; infos only, mostly the Flutter 3.50
`material.dart` deprecation across the app), `flutter test` (28 passed: `test/battle_client_test.dart`
against an in-process gRPC server, `test/battle_state_test.dart`).

Not tested: a real battle between two devices against the server, Postgres and Redis; the battle
screens themselves (no widget tests).

Next: run two clients against a local `mnstrv2server` on its `battle` branch (needs `REDIS_URL`),
then merge `battle` in mnstrv2proto, mnstrv2server and here, and deploy the server before shipping the
app (the old `/ws` endpoint is gone).
