part of '../main_page.dart';

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({
    required this.selctedTab,
    required this.onTabChanged,
  });

  final MainPageTabsEnum selctedTab;
  final ValueChanged<MainPageTabsEnum> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 80),
      painter: const _ResponsiveSVGBottomNavPainter(),
      child: Container(
        padding: const EdgeInsets.only(
          top: 24,
          bottom: 12,
          left: 20,
          right: 20,
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: MainPageTabsEnum.values.map((item) {
              if (item == MainPageTabsEnum.addAnnoyncment) {
                return const Expanded(flex: 2, child: SizedBox());
              }
              final bool isSelected = item == selctedTab;
              return Expanded(
                child: Bounce(
                  onTap: () {
                    onTabChanged(item);
                  },
                  child: Column(
                    spacing: 4,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSwitcher(
                        duration: Durations.medium3,
                        child: SizedBox(
                          key: ValueKey(selctedTab),
                          child: AppSvgIcon(
                            path: !isSelected ? item.outlineIc : item.filledIc,
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Durations.medium3,
                        height: 3,
                        width: isSelected ? 14 : 0,
                        decoration: const BoxDecoration(
                          // gradient: AppColors.primaryGradiant,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
