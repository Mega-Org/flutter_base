part of core;
class AppScaledBox extends StatelessWidget {
  const AppScaledBox({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: ResponsiveValue<double>(
        context,
        defaultValue: 450,
        conditionalValues: const [
          Condition.between(
            start: 0,
            end: 370,
            value: 355,
            landscapeValue: 500,
          ),
          Condition.between(
            start: 370,
            end: 450,
            value: 370,
            landscapeValue: 520,
          ),
          Condition.between(
            start: 450,
            end: 800,
            value: 440,
            landscapeValue: 780,
          ),
          Condition.between(
            start: 800,
            end: 1400,
            value: 540,
            landscapeValue: 820,
          ),
          Condition.between(
            start: 1400,
            end: 9999,
            value: 640,
            landscapeValue: 900,
          ),
        ],
      ).value,
      child: BouncingScrollWrapper.builder(context, child, dragWithMouse: true),
    );
  }
}
