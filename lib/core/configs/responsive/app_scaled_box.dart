part of core;

class AppScaledBox extends StatelessWidget {
  const AppScaledBox({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: ResponsiveValue<double>(
        context,
        defaultValue: AppResponsiveLayout.scaledDefaultWidth,
        conditionalValues: AppResponsiveLayout.scaledBoxWidthConditions,
      ).value,
      child: BouncingScrollWrapper.builder(context, child, dragWithMouse: true),
    );
  }
}
