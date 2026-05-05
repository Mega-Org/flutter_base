# app_realtime

Unified realtime transport for **Pusher Channels** and **Socket.IO** behind one API: [`RealtimeRepository`](app_realtime.dart) → [`RealtimeCoordinator`](data/realtime_coordinator.dart) → adapters.

## Quick start

1. **Configure transport** — edit [`RealtimeInjectionModule`](di/realtime_injection_module.dart): set either [`RealtimeTransportConfigPusher`](config/realtime_transport_config.dart) or [`RealtimeTransportConfigSocket`](config/realtime_transport_config.dart) (default is a local Socket.IO placeholder).

2. **Dispose on scope reset** — [`resetDependenciesScope`](../../core/di/di.dart) runs [`disposeRealtimeBeforeScopeResetHook`](../../core/di/realtime_dispose_bridge.dart). Assign it in [`main.dart`](../../main.dart) after DI init so [`RealtimeCoordinator.disposeAll`](data/realtime_coordinator.dart) runs before GetIt resets.

3. **Inject** [`RealtimeRepository`](domain/realtime_repository.dart), or use [`ListenRealtimeEnvelopeUseCase`](domain/use_cases/listen_realtime_envelope_use_case.dart) / [`EmitRealtimeEventUseCase`](domain/use_cases/emit_realtime_event_use_case.dart).

## Concepts

| Piece | Role |
|--------|------|
| [`RealtimeTransportConfig`](config/realtime_transport_config.dart) | Sealed config: Pusher vs Socket; `allowGuestConnect` for public-only flows. |
| [`RealtimeConnectContext`](config/realtime_connect_context.dart) | Bearer token (or null guest) passed when connecting. |
| [`RealtimeAuthProvider`](domain/realtime_auth_provider.dart) | Supplies tokens for [`RealtimeRepository.ensureConnected`](domain/realtime_repository_impl.dart). Default impl uses [`GetTokenUseCase`](../../core/domain/use_cases/secure_storage/get_token_use_case.dart). |
| [`RealtimeCoordinator`](data/realtime_coordinator.dart) | Single owner of **broadcast streams**, **refcounts**, **subscribe dedup** (`_once`), **Pusher emit readiness** (wait for subscription / timeout). |
| [`RealtimeEnvelope`](models/realtime_envelope.dart) | Normalized inbound message: `channelKey`, `eventName`, `payload`. |

## Multi-event channels

- **Pusher**: One channel subscription receives many event names; all are forwarded as [`RealtimeEnvelope`](models/realtime_envelope.dart)s.
- **Socket.IO**: Pass [`RealtimeListenParams.socketEventNames`](domain/realtime_params.dart) to restrict server events; `null`/empty means **all** non-internal events for that logical channel key (see [`SocketRealtimeAdapter`](data/adapters/socket_realtime_adapter.dart)).

## Emit behavior

- **Socket**: Emit goes through the socket once connected ([`SocketRealtimeAdapter.emit`](data/adapters/socket_realtime_adapter.dart)).
- **Pusher**: Client trigger only works after the channel is subscribed; the coordinator **waits** for subscription (with timeout) before [`trigger`](data/adapters/pusher_realtime_adapter.dart).

## Listen options

[`RealtimeListenOptions`](models/realtime_listen_options.dart) supports optional **debounce** and **distinct** envelopes (same channel, event, JSON payload).

## Custom use cases

- Extend [`IRealtimeListenUseCase`](domain/i_realtime_listen_use_case.dart) with your own `T` and `RealtimeListenParams` subclass; map [`RealtimeEnvelope.payload`](models/realtime_envelope.dart) inside `listen`.
- Extend [`IRealtimeEmitUseCase`](domain/i_realtime_emit_use_case.dart) / [`RealtimeEmitParams`](domain/realtime_params.dart) for typed emits.

## Private Pusher channels

[`RealtimeInjectionModule`](di/realtime_injection_module.dart) wires `onAuthorizer` to POST [`authBroadcastingPath`](config/realtime_transport_config.dart) with the user token—mirror of Laravel broadcasting auth.
