part of app_realtime;

/// Domain API for realtime transport — delegates to [RealtimeCoordinator].
abstract class RealtimeRepository {
  /// Opens the transport connection with credentials from [RealtimeAuthProvider].
  DomainServiceType<Unit> ensureConnected({bool requireAuth = true});

  /// Listens for normalized envelopes; calls [ensureConnected] first.
  Stream<Either<Failure, RealtimeEnvelope>> watch(RealtimeListenParams params);

  /// Emits an event (Pusher trigger / Socket.IO emit).
  DomainServiceType<Unit> emit(RealtimeEmitParams params);

  /// Closes all channel streams and disconnects (call on logout / DI reset).
  Future<void> disposeAll();
}
