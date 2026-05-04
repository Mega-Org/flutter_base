part of '../../app_pagination.dart';

class PagingListener<PageKeyType, ItemType> extends StatelessWidget {
  const PagingListener({
    super.key,
    required this.controller,
    required this.builder,
  });

  final PaginationController<PageKeyType, ItemType> controller;
  final PagingListenerBuilderType<PageKeyType, ItemType> builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PaginationState<PageKeyType, ItemType>>(
        valueListenable: controller.paginatedStateNotifier,
        builder: (context, state, _) {
          return builder(
            context,
            state,
            state.items,
            state.status,
          );
        });
  }
}
