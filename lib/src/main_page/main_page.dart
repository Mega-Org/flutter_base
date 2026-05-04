import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/core.dart';
import 'package:flutter_base/material/auth_states/unauthenticated_bottom_sheet.dart';
import 'package:flutter_base/material/media/svg_icon.dart';
import 'package:flutter_base/material/widgets/offstage.dart';

import 'models/main_page_tabs_enum.dart';
import 'observer/main_page_observer.dart';

part 'widgets/bottom_navigation_bar.dart';
part 'widgets/bottom_nav_bg_painter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with MainPageObserverMixin {
  MainPageTabsEnum _currentTabEnum = MainPageTabsEnum.home;
  final List<MainPageTabsEnum> _loadedPages = [MainPageTabsEnum.home];

  void _addUnAuthenticatedListener() {
    UnAuthenticatedInterceptor.instance.addListener(() {
      UnAuthenticatedBottomSheet.show();
    });
  }

  void _onCurrentTapChanged(MainPageTabsEnum currentTap) {
    if (!_loadedPages.contains(currentTap)) {
      _loadedPages.add(currentTap);
    }
    _currentTabEnum = currentTap;

    setState(() {});
  }

  @override
  void onTapChanged(final MainPageTabsEnum tab) {
    _onCurrentTapChanged(tab);
  }

  @override
  void initState() {
    _addUnAuthenticatedListener();
    super.initState();
    // _getUnReadNotificationsCount();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   DeepLinksUtils.init();
    // });
  }

  // void _getUnReadNotificationsCount() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (AppAuthenticationBloc.of(context).state is AuthAuthenticatedState) {
  //       context.read<NotificationsCubit>().getUnreadNotificationCount();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _currentTabEnum.index,
        children: [
          OffStage(
            isActive: _currentTabEnum == MainPageTabsEnum.home,
            child: const SizedBox.shrink(),
          ),
          OffStage(
            isActive: _currentTabEnum == MainPageTabsEnum.favorite,
            child: const SizedBox.shrink(),
          ),
          OffStage(
            isActive: _currentTabEnum == MainPageTabsEnum.addAnnoyncment,
            child: const SizedBox.shrink(),
          ),
          OffStage(
            isActive: _currentTabEnum == MainPageTabsEnum.chats,
            child: const SizedBox.shrink(),
          ),
          OffStage(
            isActive: _currentTabEnum == MainPageTabsEnum.more,
            child: const SizedBox.shrink(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _BottomNavigationBar(
        selctedTab: _currentTabEnum,
        onTabChanged: _onCurrentTapChanged,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    UnAuthenticatedInterceptor.instance.dispose();
  }
}
