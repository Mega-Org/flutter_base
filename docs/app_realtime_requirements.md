# App realtime — requirements (review)

This document captures the agreed goals for the unified **`app_realtime`** feature so you can review scope and behavior without opening the implementation plan.

---

## 1. Purpose

- One reusable realtime layer that apps can inject (repository / use cases) instead of wiring **Pusher** or **Socket.IO** separately in each feature.
- Single coordinator owns streams, subscription lifecycle, and transport calls so logic is not duplicated across adapters.

---

## 2. Transport selection

- Configuration must be a **sealed class** (or equivalent) that selects backend type and holds **type-specific values** (e.g. Pusher: key, cluster, auth path; Socket: URL, path, headers, query).
- Runtime behavior: **either** Pusher **or** Socket according to that config — one active transport per coordinator instance.

---

## 3. Structure & packaging

- Feature lives under **`lib/src/app_realtime/`** as a **`library`** using **`part` / `part of`** (same pattern as other internal features such as pagination).
- Internal layout: **config**, **models**, **data** (coordinator + adapters), **domain** (repository, auth abstraction, use-case contracts), **di** (injectable module / hooks).

---

## 4. Abstraction & reuse

- **Domain**: `RealtimeRepository` is the main façade for datasources — implementations delegate only to the **coordinator**, not to raw SDKs.
- **Coordinator**:
  - Owns broadcast streams and **refcounts** per logical channel.
  - Performs **deduplicated** connect/subscribe via shared in-flight futures (`_once`-style behavior).
  - Normalizes inbound traffic to **`RealtimeEnvelope`** (`channelKey`, `eventName`, `payload`).
- **Adapters** (`RealtimeTransport`): connect, disconnect, subscribe, unsubscribe, emit — **no** duplicated stream orchestration.

---

## 5. Multi-event channels

- **Pusher**: One channel subscription can receive **many** named events — all must map into envelopes (same channel key, varying `eventName`).
- **Socket.IO**: Logical “channel” is an app-defined key; restrict server events via optional **event name filters** where relevant.
- Optional filtering / tuning at listen time (e.g. debounce, distinct) — applied at repository/coordinator side so adapters stay thin.

---

## 6. Emit semantics

- **Pusher**: Client **trigger** only works after the channel is **subscribed** locally — track readiness; **wait** (with timeout) or fail clearly; optional logical **queue** until subscription succeeds (design intent: avoid blind triggers).
- **Socket.IO**: Emit after connection rules defined by your API (adapter connects with optional auth).

---

## 7. Subscriptions & cleanup

- **Multiple listeners** on the same channel: **refcount** — first listener triggers transport subscribe; last listener triggers unsubscribe.
- **Unsubscribe** must be explicit and reliable when refcount reaches zero.
- **DI / session reset**: When dependency scope resets or user logs out, **dispose all** realtime streams and disconnect — no leaked controllers or duplicate connections after re-init.

---

## 8. Authentication & guests

- **Guest / not logged in**: Support flows where connection is allowed **without** a bearer token when **`allowGuestConnect`** (or equivalent) is set on config.
- **Logged-in users**: Use **`RealtimeAuthProvider`** (or equivalent) to supply tokens for socket handshake and for **private/presence Pusher** channels.
- **Private Pusher channels**: Channel authorization should be **encapsulated** (e.g. HTTP POST to broadcasting auth endpoint with bearer token), not scattered in UI.

---

## 9. Domain & use cases

- **`IUseCase`** in core is `Future<Either<Failure, T>>` — streaming does not fit `call()` alone.
- **Emit**: Provide **`IRealtimeEmitUseCase`** extending **`IUseCase<Unit, P>`** (success without payload) with params for channel, event, payload, auth flags, timeouts where needed.
- **Listen**: Separate **`IRealtimeListenUseCase<T, P>`** exposing **`Stream<Either<Failure, T>> listen(P)`** (or project-standard variant).
- **Params**: Shared base fields (e.g. `channelName`, optional event filters); **subclass** for feature-specific payloads when needed.

---

## 10. Integration points

- **Injectable**: Register transport config, coordinator, repository, auth provider, and example/listen+emit use cases.
- **Scope reset**: Bridge hook so **`disposeAll`** runs **before** GetIt scope reset (see `realtime_dispose_bridge.dart` + assignment from app entry).

---

## 11. Documentation & legacy removal

- Maintain **README** under `lib/src/app_realtime/` explaining config, guest vs auth, multi-event behavior, emit readiness, refcount/unsubscribe, DI dispose, and example wiring (repository / cubit).
- Remove legacy **`lib/src/pusher`** and **`lib/src/_socket`** (when present) after migration; no direct `PusherHandler` / ad-hoc socket datasources in features.

---

## 12. Non-goals / constraints (explicit)

- Pusher **server** rules (who may trigger events) cannot be bypassed by the client — local readiness only ensures **local** subscription state.
- Socket “rooms” vs global events are API-specific; if your backend uses rooms, extend params/adapters (e.g. join/leave emits) while keeping the same domain envelope model where possible.

---

## 13. Review checklist

Use this list when reviewing the implementation against these requirements:

| # | Requirement | Verify |
|---|-------------|--------|
| 1 | Sealed transport config with per-type values | `config/realtime_transport_config.dart` |
| 2 | Coordinator owns streams + refcount + `_once` dedup | `data/realtime_coordinator.dart` |
| 3 | Envelope model for all inbound events | `models/realtime_envelope.dart` |
| 4 | Pusher emit waits for subscription / timeout | coordinator + `RealtimeEmitParams` |
| 5 | Guest connect flag | `allowGuestConnect` on config |
| 6 | Auth provider + broadcasting auth for Pusher | `RealtimeAuthProvider`, `RealtimeInjectionModule` |
| 7 | Repository + listen/emit use cases | `domain/` |
| 8 | DI + dispose before scope reset | `realtime_injection_module.dart`, `main.dart`, bridge |
| 9 | README for consumers | `lib/src/app_realtime/README.md` |
|10 | Legacy pusher/socket folders removed | repo tree / grep |

---

*Generated for internal review. Update this file when product requirements change.*
