part of app_realtime;

/// Trailing debounce for stream events (used when [RealtimeListenOptions.debounce] is set).
final class _DebounceStreamTransformer<T> extends StreamTransformerBase<T, T> {
  _DebounceStreamTransformer(this.duration);

  final Duration duration;

  @override
  Stream<T> bind(Stream<T> stream) {
    late StreamController<T> controller;
    Timer? timer;
    StreamSubscription<T>? subscription;

    controller = StreamController<T>(
      sync: true,
      onListen: () {
        subscription = stream.listen(
          (event) {
            timer?.cancel();
            timer = Timer(duration, () {
              if (!controller.isClosed) {
                controller.add(event);
              }
            });
          },
          onError: controller.addError,
          onDone: () {
            timer?.cancel();
            controller.close();
          },
          cancelOnError: false,
        );
      },
      onCancel: () {
        timer?.cancel();
        subscription?.cancel();
      },
    );
    return controller.stream;
  }
}
