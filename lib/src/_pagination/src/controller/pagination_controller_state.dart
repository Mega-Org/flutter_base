part of app_pagination;

abstract class PaginationControllerState<K, E, T extends StatefulWidget>
    extends State<T> {
// mixin PaginationControllerMixin<K, E, T extends StatefulWidget> on State<T> {
  PaginationController<K, E> get paginationController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        paginationController.init(
          screenHeight: MediaQuery.of(context).size.height,
        );
        paginationController.addPageRequestListener(pageRequestListener);
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget ScrollListenerWrapper({
    required ScrollListenerWrapperType<K, E> builder,
  }) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        paginationController.onReceiveNotification(notification);
        return false;
      },
      child: PagingListener<K, E>(
        controller: paginationController,
        builder: (context, state, items, status) {
          return builder(
            context,
            state,
            items,
            status,
            (index) => _buildItem(state, index),
          );
        },
      ),
    );
  }

  Widget listBuilder(
    PaginationState<K, E> state,
    Widget Function(int index) itemBuilder,
  );

  Widget itemBuilder(E item, int index);

  Widget _buildItem(PaginationState<K, E> state, int index) {
    if (index == state.items.length - 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          itemBuilder(state.items[index], index),
          if (state.isLoading)
            newPageLoadingBuilder
          else if (state.failure != null)
            newPageError
        ],
      );
    }
    return itemBuilder(state.items[index], index);
  }

  void pageRequestListener(K pageKey);

  Widget get firstPageError {
    return PaginatedFirstPageFailure(
      retry: paginationController.retryLastFailedRequest,
      failure: paginationController.state.failure,
    );
  }

  Widget get newPageError {
    return PaginatedNewPageFailure(
      retry: paginationController.retryLastFailedRequest,
      failure: paginationController.state.failure,
    );
  }

  final Widget firstPageLoadingBuilder = const PaginatedFirstPageLoading();
  final Widget noItemsFoundBuilder = const PaginationNoItemsFound();
  final Widget newPageLoadingBuilder = const PaginatedNewPageLoading();

  @override
  void dispose() {
    paginationController.removePageRequestListener(pageRequestListener);
    super.dispose();
  }
}
