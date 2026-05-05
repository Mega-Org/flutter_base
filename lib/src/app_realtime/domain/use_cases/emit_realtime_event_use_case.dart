part of app_realtime;

@Injectable()
final class EmitRealtimeEventUseCase
    implements IRealtimeEmitUseCase<RealtimeEmitParams> {
  EmitRealtimeEventUseCase(this._repository);

  final RealtimeRepository _repository;

  @override
  DomainServiceType<Unit> call(RealtimeEmitParams params) =>
      _repository.emit(params);
}
