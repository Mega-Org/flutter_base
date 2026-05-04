part of app_pagination;

class PaginatedListView<K, T> extends StatefulWidget {
  final PaginationController<K, T> controller;
  final ScrollPhysics? physics;
  final Key? listKey;
  final Axis scrollDirection; // New parameter for scroll direction

  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget Function(BuildContext context, Failure failure)?
  firstPageErrorBuilder;
  final Widget Function(BuildContext context)? firstPageLoadingBuilder;
  final Widget Function(BuildContext context)? noItemsFoundBuilder;
  final Widget Function(BuildContext context)? newPageLoadingBuilder;
  final Widget Function(BuildContext context, Failure failure)?
  newPageErrorBuilder;

  final double? cacheExtent;
  final EdgeInsetsGeometry? padding;
  final ScrollController? scrollController;
  final bool useSliver;
  final bool hasScrollBody;

  const PaginatedListView({
    super.key,
    required this.controller,
    this.physics,
    this.listKey,
    required this.itemBuilder,
    this.firstPageErrorBuilder,
    this.firstPageLoadingBuilder,
    this.noItemsFoundBuilder,
    this.newPageLoadingBuilder,
    this.newPageErrorBuilder,
    this.cacheExtent,
    this.padding,
    this.scrollController,
    this.scrollDirection = Axis.vertical, // Default to vertical
  }) : useSliver = false,
       hasScrollBody = true;

  const PaginatedListView.sliver({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.firstPageErrorBuilder,
    this.firstPageLoadingBuilder,
    this.noItemsFoundBuilder,
    this.newPageLoadingBuilder,
    this.newPageErrorBuilder,
    this.listKey,
    this.cacheExtent,
    this.padding,
    this.scrollController,
    this.scrollDirection = Axis.vertical, // Default to vertical
    this.hasScrollBody = true,
  }) : useSliver = true,
       physics = null;

  @override
  State<PaginatedListView<K, T>> createState() =>
      _PaginatedListViewState<K, T>();
}

class _PaginatedListViewState<K, T> extends State<PaginatedListView<K, T>> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.init(screenHeight: MediaQuery.of(context).size.height);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        widget.controller.onReceiveNotification(notification);
        return false;
      },
      child: ValueListenableBuilder<PaginationState<K, T>>(
        valueListenable: widget.controller.paginatedStateNotifier,
        builder: (context, state, child) {
          if (widget.useSliver) {
            if (state.items.isEmpty) {
              return SliverFillRemaining(
                hasScrollBody: widget.hasScrollBody,
                child: _firstPageStateBuilder(state),
              );
            }
            return SliverPadding(
              padding: widget.padding ?? EdgeInsets.zero,
              sliver: widget.scrollDirection == Axis.horizontal
                  ? SliverList(
                      key: widget.listKey,
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _buildItem(state, index),
                        childCount: state.items.length,
                      ),
                    )
                  : SliverList.builder(
                      key: widget.listKey,
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        return _buildItem(state, index);
                      },
                    ),
            );
          } else {
            if (state.items.isEmpty) {
              return _firstPageStateBuilder(state);
            }
            return ListView.builder(
              key: widget.listKey,
              controller: widget.scrollController,
              scrollDirection: widget.scrollDirection, // Set scroll direction
              physics: widget.physics,
              itemCount: state.items.length,
              cacheExtent: widget.cacheExtent,
              padding: widget.padding,
              itemBuilder: (context, index) {
                return _buildItem(state, index);
              },
            );
          }
        },
      ),
    );
  }

  Widget _firstPageStateBuilder(PaginationState state) {
    if (state.isLoading) {
      return widget.firstPageLoadingBuilder?.call(context) ??
          const PaginatedFirstPageLoading();
    } else if (state.failure != null) {
      return widget.firstPageErrorBuilder?.call(context, state.failure!) ??
          PaginatedFirstPageFailure(
            retry: widget.controller.retryLastFailedRequest,
            failure: widget.controller.state.failure,
          );
    } else {
      return widget.noItemsFoundBuilder?.call(context) ??
          const PaginationNoItemsFound();
    }
  }

  Widget _buildItem(PaginationState state, int index) {
    if (index == state.items.length - 1) {
      switch (widget.scrollDirection) {
        case Axis.horizontal:
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.itemBuilder(context, state.items[index], index),
              if (state.isLoading)
                widget.newPageLoadingBuilder?.call(context) ??
                    const PaginatedNewPageLoading()
              else if (state.failure != null)
                widget.newPageErrorBuilder?.call(context, state.failure!) ??
                    PaginatedNewPageFailure(
                      retry: widget.controller.retryLastFailedRequest,
                      failure: widget.controller.state.failure,
                    ),
            ],
          );
        case Axis.vertical:
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.itemBuilder(context, state.items[index], index),
              if (state.isLoading)
                widget.newPageLoadingBuilder?.call(context) ??
                    const PaginatedNewPageLoading()
              else if (state.failure != null)
                widget.newPageErrorBuilder?.call(context, state.failure!) ??
                    PaginatedNewPageFailure(
                      retry: widget.controller.retryLastFailedRequest,
                      failure: widget.controller.state.failure,
                    ),
            ],
          );
      }
    }

    return widget.itemBuilder(context, state.items[index], index);
  }
}
