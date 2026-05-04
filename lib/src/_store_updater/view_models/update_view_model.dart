part of '../store_updater.dart';

class UpdateViewModel extends ChangeNotifier {
  final _IUpdateRepository _repository = _IUpdateRepository();
  final _deleteCachedUserUseCase = DeleteCachedUserUseCase.getInstance();

  static UpdateViewModel? _instance;

  UpdateViewModel._();

  static UpdateViewModel get _getInstance {
    return _instance ??= UpdateViewModel._();
  }

  // factory UpdateViewModel() => instance;

  static void init() async {
    if (kDebugMode) {
      return;
    }
    _getInstance.checkUpdate();
    _getInstance._addUpdateListener();
  }

  void _addUpdateListener() {
    _repository.onConfigChanged.listen((event) {
      if (event != null) {
        checkUpdate();
      }
    });
  }

  Future<bool> get hasAvailableUpdate async {
    try {
      return await _repository.isUpdateAvailable();
    } catch (_) {
      return false;
    }
  }

  /// Checks for updates and shows the dialog if needed.
  ///
  Timer? _checkUpdateDebounceTimer;
  Future<void> checkUpdate() async {
    _checkUpdateDebounceTimer?.cancel();
    _checkUpdateDebounceTimer = Timer(const Duration(seconds: 2), () async {
      _checkUpdateDebounceTimer?.cancel();
      final bool hasUpdate = await hasAvailableUpdate;
      if (hasUpdate) {
        final UpdateEntity updateEntity = await _repository.getUpdateInfo();
        if (updateEntity.canUpdate) {
          _cleanAllUserCachedDataOnExistNewUpdate(updateEntity);
          _showUpdateDialog(updateEntity);
        } else {
          _closeUpdateDialog();
        }
      } else {
        _closeUpdateDialog();
      }
    });
  }

  void _showUpdateDialog(UpdateEntity updateEntity) {
    try {
      final BuildContext? context = appNavigatorKey.currentContext;
      if (context != null && context.mounted) {
        final _PlatformConfig config = _PlatformConfig.fromPlatform();
        _AppUpdateDialog.show(
          context,
          config: config,
          updateData: updateEntity,
        );
      }
    } catch (_) {
      debugPrint('[StoreUpdater] ::: UpdateViewModel Show Update Dialog Error');
    }
  }

  void _closeUpdateDialog() {
    try {
      final BuildContext? context = appNavigatorKey.currentContext;
      if (context != null && context.mounted) {
        _AppUpdateDialog.close(context);
      }
    } catch (_) {
      debugPrint('[StoreUpdater] ::: UpdateViewModel Show Update Dialog Error');
    }
  }

  void _cleanAllUserCachedDataOnExistNewUpdate(UpdateEntity updateInfo) {
    if (updateInfo.isForceUpdate) {
      _deleteCachedUserUseCase();
    }
  }
}
