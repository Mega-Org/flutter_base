// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

part of app_pagination;

class PaginationController<K, T> {
  final K initialPageKey;
  bool Function(ScrollNotification scrollNotification)? customTriggerThreshold;
  final ScrollController? scrollController;

  PaginationController({
    required this.initialPageKey,
    this.customTriggerThreshold,
    this.scrollController,
  }) {
    _paginatedStateNotifier = ValueNotifier(
      PaginationState<K, T>.initial(initialKey: initialPageKey),
    );
  }

  double _screenHeight = 0;
  double _triggerExtent = 0;
  double get getTriggerExtent => _triggerExtent;
  void setCustomTriggerThreshold(
    bool Function(ScrollNotification scrollNotification) threshold,
  ) {
    customTriggerThreshold = threshold;
  }

  void removeCustomTriggerThreshold() {
    customTriggerThreshold = null;
  }

  /// State that contains data, loading, failure. pageInfo ..etc
  @protected
  late final ValueNotifier<PaginationState<K, T>> _paginatedStateNotifier;
  ValueNotifier<PaginationState<K, T>> get paginatedStateNotifier =>
      _paginatedStateNotifier;
  PaginationState<K, T> get state => _paginatedStateNotifier.value;

  /// Manage Request Pages Operations
  /// Handle Paged State
  /// Handle Loading , Failer , Success
  ///
  ///

  // List of page request listeners
  final _listeners = ObserverList<PageRequestListenerType<K>>();
  Completer? _requestCompleter;

  void _requestCompleted() {
    if (!(_requestCompleter?.isCompleted ?? true)) {
      _requestCompleter?.complete();
    }

    _requestCompleter = null;
  }

  void _setRequestCompleter() {
    _requestCompleted();
    _requestCompleter = Completer();
  }

  void addPageRequestListener(PageRequestListenerType<K> callback) {
    if (!_listeners.contains(callback)) {
      _listeners.add(callback);
    }

    _requestCompleted();
  }

  void removePageRequestListener(PageRequestListenerType<K> callback) {
    _listeners.remove(callback);
  }

  void triggerFetchListeners({K? newPageKey}) {
    if (state.isLastPage) {
      return;
    }

    _paginatedStateNotifier.value = _paginatedStateNotifier.value.copyWith(
      isLoading: true,
      pageKey: newPageKey,
      failure: null,
    );

    for (var listener in _listeners) {
      listener(state.pageKey);
    }

    _setRequestCompleter();

    _paginatedStateNotifier.notifyListeners();
  }

  void setError(Failure? failure) {
    _paginatedStateNotifier.value = _paginatedStateNotifier.value
        .copyWith(isLoading: false, failure: failure);

    _requestCompleted();
  }

  void retryLastFailedRequest() {
    _paginatedStateNotifier.value =
        _paginatedStateNotifier.value.copyWith(failure: null, isLoading: true);

    triggerFetchListeners();
    _paginatedStateNotifier.notifyListeners();
  }

  void refresh() {
    _setRequestCompleter();

    _paginatedStateNotifier.value =
        PaginationState<K, T>.initial(initialKey: initialPageKey);

    for (var listener in _listeners) {
      listener(state.pageKey);
    }

    _paginatedStateNotifier.notifyListeners();
  }

  void appendPage({
    required List<T> newItems,
    required K newKey,
    required bool isLastPage,
  }) {
    final K currentKey = state.pageKey;
    final List<T> items = List<T>.from(state.items);
    if (newKey != currentKey) {
      items.addAll(newItems);
    }
    _paginatedStateNotifier.value = _paginatedStateNotifier.value.copyWith(
      isLoading: false,
      isLastPage: isLastPage,
      pageKey: newKey,
      items: items,
      failure: state.failure,
    );

    _requestCompleted();
    _paginatedStateNotifier.notifyListeners();
  }

  void insertPage({
    required List<T> newItems,
    required K newKey,
    required bool isLastPage,
    int insertAt = 0,
  }) {
    final List<T> nextItems;
    if (state.items.isEmpty) {
      nextItems = <T>[...newItems];
    } else {
      nextItems = List<T>.from(state.items)..insertAll(insertAt, newItems);
    }
    _paginatedStateNotifier.value = _paginatedStateNotifier.value.copyWith(
      isLoading: false,
      isLastPage: isLastPage,
      pageKey: newKey,
      items: nextItems,
    );

    _requestCompleted();
  }

  bool initCalled = false;
  void init({required double screenHeight, double? triggerExtent}) {
    // Set screen height and trigger extent
    _screenHeight = screenHeight;
    _triggerExtent = triggerExtent ?? (_screenHeight * 0.8);

    if (!initCalled) {
      //Trigger initial request
      triggerFetchListeners();
    }

    if (scrollController != null) {
      scrollController!.addListener(_onScrollControllerListener);
    }

    initCalled = true;
  }

  /// Stop listening to the scroll controller or the request listeners when this condition comes true
  bool get _shouldStopListening {
    // return state.status is! PaginatedStatusNewPageError;
    return state.isLoading || state.isLastPage || state.failure != null;
  }

  void onReceiveNotification(ScrollNotification scrollNotification) {
    if (_shouldStopListening) return;

    final bool isMaxScrollExtentExceeded = scrollNotification.metrics.pixels >=
        scrollNotification.metrics.maxScrollExtent - _triggerExtent;
    if (customTriggerThreshold?.call(scrollNotification) ??
        isMaxScrollExtentExceeded) {
      triggerFetchListeners();
    }
  }

  void _onScrollControllerListener() {
    if (scrollController == null) return;
    if (_shouldStopListening || scrollController == null) return;

    final double pixels = scrollController!.position.pixels;
    final double maxScrollExtent = scrollController!.position.maxScrollExtent;

    final bool isMaxScrollExtentExceeded =
        pixels >= maxScrollExtent - _triggerExtent;

    if (isMaxScrollExtentExceeded) {
      triggerFetchListeners();
    }
  }

  /// List Of Operations Helpers For Items
  ///
  ///

  void updateItemsList(List<T> newItems) {
    _paginatedStateNotifier.value = _paginatedStateNotifier.value
        .copyWith(items: newItems, failure: state.failure);
    _paginatedStateNotifier.notifyListeners();
  }

  List<T> get itemList => state.items;
  set itemList(List<T> newList) {
    _paginatedStateNotifier.value = _paginatedStateNotifier.value.copyWith(
      items: newList,
      failure: state.failure,
    );
  }

  T? getItemWhere(bool Function(T e) cond) {
    return state.items.firstWhereOrNull(cond);
  }

  void updateItem({
    required bool Function(T e) updateWhere,
    required T Function(T oldItem) newItem,
  }) {
    final itemList = _paginatedStateNotifier.value.items;

    if (itemList.isEmpty) return;

    final index = itemList.firstIndexWhere(updateWhere);

    if (index != null) {
      final List<T> newList = List<T>.from(itemList);
      newList[index] = newItem(newList[index]);

      _paginatedStateNotifier.value = _paginatedStateNotifier.value
          .copyWith(items: newList, failure: state.failure);
      _paginatedStateNotifier.notifyListeners();
    } else {
      // logDebug("item Not found in List ");
    }
  }

  void removeItem(
    bool Function(T e) removeWhere,
  ) {
    final itemList = _paginatedStateNotifier.value.items;

    if (itemList.isEmpty) {
      return;
    }

    final List<T> newList = List<T>.from(itemList);
    newList.removeWhere(removeWhere);
    _paginatedStateNotifier.value = _paginatedStateNotifier.value
        .copyWith(items: [...newList], failure: state.failure);
    _paginatedStateNotifier.notifyListeners();

    // if the user kept removing items and the list gets empty,
    // there is no request will be triggered because the user did not scroll, so we add this to make sure that the request will be triggered if it pass the triggerExtent
    //_triggerRequestIfNeeded();
  }

  void addItem(T item, {int? atIndex, bool appendIfListIsEmpty = false}) {
    final itemList = _paginatedStateNotifier.value.items;

    if (itemList.isEmpty) {
      if (appendIfListIsEmpty) {
        _paginatedStateNotifier.value = _paginatedStateNotifier.value
            .copyWith(items: [item], failure: state.failure);
      }
      _paginatedStateNotifier.notifyListeners();
      return;
    }

    final List<T> newList = List<T>.from(itemList);

    if (atIndex != null) {
      if (newList.isEmpty) {
        newList.add(item);
      } else {
        newList.insert(atIndex, item);
      }
    } else {
      newList.add(item);
    }

    _paginatedStateNotifier.value = _paginatedStateNotifier.value.copyWith(
      items: newList,
      failure: state.failure,
    );
    _paginatedStateNotifier.notifyListeners();
  }

  /// Keeps the first item for each distinct [keyOf] value.
  List<T> uniqueByKey<KKey>(KKey Function(T element) keyOf) {
    final seen = <KKey>{};
    final out = <T>[];
    for (final element in state.items) {
      if (seen.add(keyOf(element))) {
        out.add(element);
      }
    }
    return out;
  }

  void dispose() {
    _listeners.clear();
    if (scrollController != null) {
      scrollController!.removeListener(_onScrollControllerListener);
    }
    _paginatedStateNotifier.dispose();
  }
}

extension PaginationControllerExtension<T> on PaginationController<int, T> {
  void addItems(PaginatedData<T> items) {
    if (state.pageKey == 1) {
      _paginatedStateNotifier.value =
          PaginationState<int, T>.initial(initialKey: initialPageKey);
    }
    appendPage(
      newKey: state.pageKey + 1,
      newItems: items.items,
      isLastPage: !items.pageInfo.hasNext,
    );
  }

  void removeDuplicatedItemsWhere(bool Function(T first, T second) cond) {
    final List<T> tempList = List<T>.from(state.items);
    final List<T> newList = <T>[];
    for (final T item in tempList) {
      final bool isExistInNewList = newList.any((e) => cond(e, item));
      if (!isExistInNewList) {
        newList.add(item);
      }
    }
    _paginatedStateNotifier.value =
        _paginatedStateNotifier.value.copyWith(items: newList);
    _paginatedStateNotifier.notifyListeners();
  }
}
