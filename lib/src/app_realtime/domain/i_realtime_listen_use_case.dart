part of app_realtime;

/// Streaming counterpart to [IUseCase] for realtime listen flows.
abstract class IRealtimeListenUseCase<T, P extends RealtimeListenParams> {
  Stream<Either<Failure, T>> listen(P params);
}
