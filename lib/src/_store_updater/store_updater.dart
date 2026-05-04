import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';

/// Constants
part 'constants/constants.dart';

/// Models
part 'models/config_model.dart';
part 'models/update_entity.dart';

/// Repositories
part 'repositories/store_update_repository.dart';

/// Views
part 'views/update_dialog.dart';

/// ViewModels
part 'view_models/update_view_model.dart';

//// MOCK JSON Examble
///
/// Android Key : app_update_config_android
// final mockJson = 
      // {
      //   "is_enabled": true,
      //   "min_version": "1.0.3",
      //   "force_update": true
      // }
///
///
/// Ios Key : app_update_config_ios
// final mockJson = 
      // {
      //   "is_enabled": true,
      //   "min_version": "1.0.3+4",
      //   "force_update": true
      // }

