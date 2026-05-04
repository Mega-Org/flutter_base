part of app_pagination;

typedef PageRequestListenerType<K> = void Function(K pageKey);

typedef PagingListenerBuilderType<K, E> = Widget Function(
  BuildContext context,
  PaginationState<K, E> state,
  List<E> items,
  PaginatedStatus status,
);

typedef ScrollListenerWrapperType<K, E> = Widget Function(
  BuildContext context,
  PaginationState<K, E> state,
  List<E> items,
  PaginatedStatus status,
  Widget Function(int index) itemBuilder,
);

typedef FirstPageBuilderType<K, T> = Widget Function(
  PaginationState<K, T> state,
  Widget Function(PaginationState<K, T> state, int index) itemBuilder,
);

typedef ItemBuilderType<K, E> = Widget Function(
  E item,
  int index,
);

/// Typical API payload wrapper for [PaginationControllerExtension.addItems].
class PaginatedData<T> {
  const PaginatedData({
    required this.items,
    required this.pageInfo,
  });

  final List<T> items;
  final PageInfo pageInfo;
}

class PageInfo {
  const PageInfo({required this.hasNext});

  final bool hasNext;
}
