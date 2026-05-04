part of app_pagination;

class PaginatedFirstPageLoading extends StatelessWidget {
  const PaginatedFirstPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitLoadingWidget.medium(),
    );
  }
}

class PaginatedNewPageLoading extends StatelessWidget {
  const PaginatedNewPageLoading({
    super.key,
    this.color = const Color(0xff999999),
  });
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  appLocalizer.paginationLoadingMore,
                  textAlign: TextAlign.start,
                  style: TextStyles.medium12
                      .copyWith(color: color)
                      .copyWith(height: 1),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            SpinKitLoadingWidget(
              color: color,
              size: 12,
              count: 2,
            ),
          ],
        ),
      ),
    );
  }
}
