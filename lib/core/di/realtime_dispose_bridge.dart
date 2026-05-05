/// Assigned from app entry (e.g. [main]) after DI init so realtime connections
/// close before [resetDependenciesScope] tears down GetIt.
Future<void> Function()? disposeRealtimeBeforeScopeResetHook;
