part of '../store_updater.dart';

class _AppUpdateDialog extends StatelessWidget {
  final _PlatformConfig config;
  final UpdateEntity updateData;

  const _AppUpdateDialog({required this.config, required this.updateData});

  static const String routeName = "_AppUpdateDialog";

  static void show(
    BuildContext context, {
    required final _PlatformConfig config,
    required final UpdateEntity updateData,
  }) async {
    return await showGeneralDialog<void>(
      context: context,
      barrierDismissible: !updateData.isForceUpdate,
      barrierLabel: routeName,
      routeSettings: const RouteSettings(name: routeName),
      pageBuilder:
          (
            BuildContext buildContext,
            Animation animation,
            Animation secondaryAnimation,
          ) {
            return Center(
              child: Material(
                type: MaterialType.transparency,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SafeArea(
                        child: _AppUpdateDialog(
                          config: config,
                          updateData: updateData,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).viewInsets.bottom,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static void close(BuildContext context) async {
    String? currentRoute;
    appNavigatorKey.currentState?.popUntil((route) {
      currentRoute = route.settings.name;
      return true;
    });
    if (currentRoute == routeName && context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _launchStore() async {
    final Uri url = Uri.parse(config.storeUrl);
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardColor,
      // titleTextStyle: TextStyles.bold18.copyWith(color: AppColors.textColor),
      contentTextStyle: TextStyles.regular14.copyWith(
        color: AppColors.hintColor,
      ),
      title: Text(appLocalizer.storeUpdaterTitle, textAlign: TextAlign.center),
      content: Text(
        appLocalizer.storeUpdaterMessage,
        textAlign: TextAlign.center,
      ),
      actions: [
        ElevatedButton(
          onPressed: _launchStore,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          child: Text(appLocalizer.storeUpdaterBtnLabel),
        ),
        if (!updateData.isForceUpdate) ...[
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: Navigator.of(context).pop,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(appLocalizer.cancel),
          ),
        ],
      ],
    );
  }
}
