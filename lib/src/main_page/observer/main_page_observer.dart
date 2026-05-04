import 'package:flutter/material.dart';

import '../models/main_page_tabs_enum.dart';

part 'main_page_updater.dart';
part "main_page_mixin.dart";

class MainPageObserver<StudentMainPageTabsEnum> {
  final void Function(StudentMainPageTabsEnum tab)? onTabChanged;

  MainPageObserver({this.onTabChanged}) {
    MainPageUpdater.instance.attachObserver(this);
  }

  void dispose() {
    MainPageUpdater.instance.deAttachObserver(this);
  }

  void _notifyOnChangedCallbacks(StudentMainPageTabsEnum tab) {
    if (onTabChanged != null) {
      onTabChanged!(tab);
    }
  }
}
