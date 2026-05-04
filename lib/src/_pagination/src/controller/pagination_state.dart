part of app_pagination;

class PaginationState<K, T> extends Equatable {
  final K pageKey;
  final bool isLastPage;
  final bool isLoading;
  final Failure? failure;
  final List<T> items;

  const PaginationState({
    required this.pageKey,
    required this.isLastPage,
    required this.isLoading,
    required this.failure,
    required this.items,
  });

  const PaginationState.initial({required K initialKey})
      : this(
          isLoading: true,
          isLastPage: false,
          items: const [],
          pageKey: initialKey,
          failure: null,
        );

  static const Object _sentinel = Object();

  PaginationState<K, T> copyWith({
    K? pageKey,
    bool? isLastPage,
    bool? isLoading,
    List<T>? items,
    Object? failure = _sentinel,
  }) {
    return PaginationState<K, T>(
      pageKey: pageKey ?? this.pageKey,
      isLastPage: isLastPage ?? this.isLastPage,
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      failure: identical(failure, _sentinel)
          ? this.failure
          : failure as Failure?,
    );
  }

  bool get _isFirstPageLoading =>
      isLoading && items.isEmpty && isLastPage == false;
  bool get _isFirstPageFailure =>
      failure != null && items.isEmpty && isLastPage == false;
  bool get _isNoItemsFound =>
      items.isEmpty && isLastPage && failure == null && isLoading == false;
  bool get _isLoadMoreLoading =>
      isLoading && items.isNotEmpty && isLastPage == false;
  bool get _isLoadMoreFailure =>
      failure != null && items.isNotEmpty && isLastPage == false;
  bool get isCompleted => isLastPage && failure == null && isLoading == false;

  PaginatedStatus get status => PaginatedStatus.fromState<K, T>(this);

  @override
  List<Object?> get props => [
        pageKey,
        isLastPage,
        isLoading,
        failure,
        items,
      ];
}
