part of app_realtime;

@Injectable()
final class ListenRealtimeEnvelopeUseCase
    implements IRealtimeListenUseCase<RealtimeEnvelope, RealtimeListenParams> {
  ListenRealtimeEnvelopeUseCase(this._repository);

  final RealtimeRepository _repository;

  @override
  Stream<Either<Failure, RealtimeEnvelope>> listen(
    RealtimeListenParams params,
  ) =>
      _repository.watch(params);
}
