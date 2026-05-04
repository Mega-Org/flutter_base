part of 'main_page_observer.dart';

mixin MainPageObserverMixin<T extends StatefulWidget> on State<T> {
  MainPageObserver? mainPageObserver;

  void _initObserver<E extends MainPageTabsEnum, K>() {
    mainPageObserver = MainPageObserver<MainPageTabsEnum>(
      onTabChanged: onTapChanged,
    );
  }

  void onTapChanged(final MainPageTabsEnum tab);

  @override
  void initState() {
    super.initState();
    _initObserver();
  }

  @override
  void dispose() {
    mainPageObserver?.dispose();
    super.dispose();
  }
}
