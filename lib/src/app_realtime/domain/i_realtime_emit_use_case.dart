part of app_realtime;

/// Emit-side use case; implements [IUseCase] with [Unit] for success.
abstract class IRealtimeEmitUseCase<P extends RealtimeEmitParams>
    implements IUseCase<Unit, P> {}
