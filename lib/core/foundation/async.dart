part of core;

class Async<T> extends Equatable {
  final T? data;
  final Failure? failure;
  final bool _successWithoutData;
  final bool? _loading;

  const Async._({
    this.data,
    required final bool successWithoutData,
    required final bool? loading,
    this.failure,
  }) : _successWithoutData = successWithoutData,
       _loading = loading;

  String? get errorMessage => failure?.message;

  bool get isLoading => _loading ?? false;

  bool get isSuccess =>
      (_successWithoutData || data != null) && (failure == null);

  bool get isFailure => failure != null;

  bool get isInitial =>
      (data == null) &&
      (failure == null) &&
      (_successWithoutData == false) &&
      (_loading == null);

  const Async.loading()
    : this._(
        data: null,
        successWithoutData: false,
        loading: true,
        failure: null,
      );

  const Async.success(final T data)
    : this._(
        data: data,
        successWithoutData: false,
        loading: false,
        failure: null,
      );

  const Async.successWithoutData()
    : this._(
        data: null,
        successWithoutData: true,
        loading: false,
        failure: null,
      );

  const Async.failure(final Failure failure)
    : this._(
        data: null,
        successWithoutData: false,
        loading: false,
        failure: failure,
      );

  const Async.initial()
    : this._(
        data: null,
        successWithoutData: false,
        loading: null,
        failure: null,
      );

  @override
  String toString() {
    return "Async : [data]: $data , [Failure]: ${failure.runtimeType} , [isFailure] : $isFailure , [isLoading] : $isLoading , [isSuccess] : $isSuccess ,[isInitial] $isInitial";
  }

  @override
  List<Object?> get props => [
    data,
    _successWithoutData,
    _loading,
    isFailure,
    isLoading,
    isSuccess,
    isInitial,
    failure,
  ];
}
