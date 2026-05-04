part of app_pagination;

class PaginatedFirstPageFailure extends StatelessWidget {
  const PaginatedFirstPageFailure({
    super.key,
    this.failure,
    required this.retry,
    this.color,
  });
  final Failure? failure;
  final VoidCallback retry;
  final Color? color;

  const PaginatedFirstPageFailure.white({
    super.key,
    this.failure,
    required this.retry,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AppFailWidget(onRetry: retry);
  }
}

class PaginatedNewPageFailure extends StatelessWidget {
  const PaginatedNewPageFailure({
    super.key,
    this.failure,
    required this.retry,
    this.color = const Color(0xFFEA0020),
  });
  const PaginatedNewPageFailure.white({
    super.key,
    this.failure,
    required this.retry,
    this.color = Colors.white,
  });

  final Failure? failure;
  final VoidCallback retry;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final borderColor = color;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: retry,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            margin: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxHeight: 35, minWidth: 20),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      appLocalizer.paginationCouldNotLoadMore,
                      textAlign: TextAlign.start,
                      style: TextStyles.medium12
                          .copyWith(color: borderColor)
                          .copyWith(height: 1),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.refresh,
                  color: borderColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
