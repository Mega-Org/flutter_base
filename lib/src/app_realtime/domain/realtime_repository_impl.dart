part of app_realtime;

@LazySingleton(as: RealtimeRepository)
final class RealtimeRepositoryImpl implements RealtimeRepository {
  RealtimeRepositoryImpl(
    this._coordinator,
    this._auth,
  );

  final RealtimeCoordinator _coordinator;
  final RealtimeAuthProvider _auth;

  @override
  DomainServiceType<Unit> ensureConnected({bool requireAuth = true}) async {
    try {
      final token = await _auth.getBearerToken();
      if (requireAuth && (token == null || token.trim().isEmpty)) {
        return const Left<Failure, Unit>(
          UnAuthorizedFailure(
            message: 'Not authenticated for realtime connection',
          ),
        );
      }
      await _coordinator.ensureConnected(
        context: RealtimeConnectContext(bearerToken: token),
        requireAuth: requireAuth,
      );
      return const Right<Failure, Unit>(unit);
    } on StateError catch (e) {
      return Left(UnexpectedFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: '$e'));
    }
  }

  @override
  Stream<Either<Failure, RealtimeEnvelope>> watch(
    RealtimeListenParams params,
  ) async* {
    final gate = await ensureConnected(requireAuth: params.requireAuth);
    yield* gate.fold<Stream<Either<Failure, RealtimeEnvelope>>>(
      (failure) => Stream<Either<Failure, RealtimeEnvelope>>.value(
        Left<Failure, RealtimeEnvelope>(failure),
      ),
      (_) => _applyStreamOptions(
        _coordinator.watch(
          params.channelName,
          socketEventFilter: params.socketEventNames,
        ),
        params.options,
      ).map<Either<Failure, RealtimeEnvelope>>(
        Right<Failure, RealtimeEnvelope>.new,
      ),
    );
  }

  @override
  DomainServiceType<Unit> emit(RealtimeEmitParams params) async {
    final connect = await ensureConnected(requireAuth: params.requireAuth);
    return connect.fold(
      (f) async => Left<Failure, Unit>(f),
      (_) async {
        return _coordinator.emit(
          channelKey: params.channelName,
          eventName: params.eventName,
          payload: params.payload,
          pusherReadyTimeout: params.pusherReadyTimeout,
        );
      },
    );
  }

  @override
  Future<void> disposeAll() => _coordinator.disposeAll();

  Stream<RealtimeEnvelope> _applyStreamOptions(
    Stream<RealtimeEnvelope> source,
    RealtimeListenOptions? options,
  ) {
    if (options == null) {
      return source;
    }
    var s = source;
    final d = options.debounce;
    if (d != null) {
      s = s.transform(_DebounceStreamTransformer<RealtimeEnvelope>(d));
    }
    if (options.distinctEnvelopes) {
      s = s.distinct(_envelopeEquals);
    }
    return s;
  }

  bool _envelopeEquals(RealtimeEnvelope a, RealtimeEnvelope b) {
    if (a.channelKey != b.channelKey || a.eventName != b.eventName) {
      return false;
    }
    try {
      return jsonEncode(a.payload) == jsonEncode(b.payload);
    } catch (_) {
      return identical(a.payload, b.payload);
    }
  }
}
