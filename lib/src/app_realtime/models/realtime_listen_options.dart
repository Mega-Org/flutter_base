part of app_realtime;

/// Optional tuning for [RealtimeRepository.watch].
class RealtimeListenOptions extends Equatable {
  const RealtimeListenOptions({
    this.debounce,
    this.distinctEnvelopes = false,
  });

  /// When set, applies a trailing debounce per event delivery.
  final Duration? debounce;

  /// When true, suppresses consecutive duplicate envelopes (same channel,
  /// event, and JSON-encoded payload).
  final bool distinctEnvelopes;

  @override
  List<Object?> get props => [debounce, distinctEnvelopes];
}
