part of app_pagination;

class PaginationNoItemsFound extends StatelessWidget {
  const PaginationNoItemsFound({super.key, this.color});
  final Color? color;

  const PaginationNoItemsFound.white({super.key}) : color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24.0),
        child: Text(
          appLocalizer.paginationNoItems,
          style: TextStyles.semiBold12.copyWith(color: color),
        ),
      ),
    );
  }
}
