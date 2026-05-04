part of app_pagination;

class PaginatedGridView<K, T> extends StatefulWidget {
  final PaginationController<K, T> controller;
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
  final bool useSliver;

  // Additional properties for Grid layout
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  const PaginatedGridView({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.firstPageErrorBuilder,
    this.firstPageLoadingBuilder,
    this.noItemsFoundBuilder,
    this.newPageLoadingBuilder,
    this.newPageErrorBuilder,
    this.cacheExtent,
    this.padding,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.childAspectRatio = 1.0,
  }) : useSliver = false;

  const PaginatedGridView.sliver({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.firstPageErrorBuilder,
    this.firstPageLoadingBuilder,
    this.noItemsFoundBuilder,
    this.newPageLoadingBuilder,
    this.newPageErrorBuilder,
    this.cacheExtent,
    this.padding,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.childAspectRatio = 1.0,
  }) : useSliver = true;

  @override
  State<PaginatedGridView<K, T>> createState() =>
      _PaginatedGridViewState<K, T>();
}

class _PaginatedGridViewState<K, T> extends State<PaginatedGridView<K, T>> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.init(
        screenHeight: MediaQuery.of(context).size.height,
      );
    });
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
                child: _firstPageStateBuilder(state),
              );
            } else {
              return SliverPadding(
                padding: widget.padding ?? EdgeInsets.zero,
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildItem(state, index),
                    childCount: state.items.length +
                        ((state.isLoading || state.failure != null) ? 1 : 0),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.crossAxisCount,
                    mainAxisSpacing: widget.mainAxisSpacing,
                    crossAxisSpacing: widget.crossAxisSpacing,
                    childAspectRatio: widget.childAspectRatio,
                  ),
                ),
              );
            }
          } else {
            if (state.items.isEmpty) {
              return _firstPageStateBuilder(state);
            }

            return GridView.builder(
              padding: widget.padding,
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
                mainAxisSpacing: widget.mainAxisSpacing,
                crossAxisSpacing: widget.crossAxisSpacing,
                childAspectRatio: widget.childAspectRatio,
              ),
              itemCount: state.items.length +
                  ((state.isLoading || state.failure != null) ? 1 : 0),
              cacheExtent: widget.cacheExtent,
              itemBuilder: (context, index) => _buildItem(state, index),
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

  Widget _buildItem(PaginationState<K, T> state, int index) {
    if (index == state.items.length) {
      if (state.isLoading) {
        return widget.newPageLoadingBuilder?.call(context) ??
            const PaginatedNewPageLoading();
      } else if (state.failure != null) {
        return widget.newPageErrorBuilder?.call(context, state.failure!) ??
            PaginatedNewPageFailure(
              retry: widget.controller.retryLastFailedRequest,
              failure: widget.controller.state.failure,
            );
      }
    }

    return widget.itemBuilder(context, state.items[index], index);
  }
}
