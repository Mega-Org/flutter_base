part of app_pagination;

sealed class PaginatedStatus extends Equatable {
  const PaginatedStatus();

  static PaginatedStatus fromState<K, T>(PaginationState<K, T> state) {
    if (state._isFirstPageLoading) {
      return const PaginatedStatusLoading();
    } else if (state._isFirstPageFailure) {
      return PaginatedStatusError(state.failure);
    } else if (state._isNoItemsFound) {
      return const PaginatedStatusNoItemsFound();
    } else if (state._isLoadMoreLoading) {
      return const PaginatedStatusNewPageLoading();
    } else if (state._isLoadMoreFailure) {
      return PaginatedStatusNewPageError(state.failure);
    } else if (state.isCompleted) {
      return PaginatedStatusCompleted<T>(state.items);
    } else {
      return PaginatedStatusCompleted<T>(state.items);
    }
  }
}

class PaginatedStatusCompleted<T> extends PaginatedStatus {
  const PaginatedStatusCompleted(this.items);
  final List<T> items;
  @override
  List<Object?> get props => [];
}

class PaginatedStatusLoading extends PaginatedStatus {
  const PaginatedStatusLoading();
  @override
  List<Object?> get props => [];
}

class PaginatedStatusError extends PaginatedStatus {
  final Failure? failure;
  const PaginatedStatusError(this.failure);
  @override
  List<Object?> get props => [failure];
}

class PaginatedStatusNoItemsFound extends PaginatedStatus {
  const PaginatedStatusNoItemsFound();
  @override
  List<Object?> get props => [];
}

class PaginatedStatusNewPageLoading extends PaginatedStatus {
  const PaginatedStatusNewPageLoading();
  @override
  List<Object?> get props => [];
}

class PaginatedStatusNewPageError extends PaginatedStatus {
  final Failure? failure;
  const PaginatedStatusNewPageError(this.failure);
  @override
  List<Object?> get props => [failure];
}
