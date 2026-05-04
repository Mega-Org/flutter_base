part of core;

class AppRateService {
  AppRateService._();

  factory AppRateService() {
    return _instance;
  }

  static final AppRateService _instance = AppRateService._();

  Future<void> popUp() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  Future<void> openStore() async {
    final InAppReview inAppReview = InAppReview.instance;

    inAppReview.openStoreListing(appStoreId: AppConstants.appStoreId);
  }
}
