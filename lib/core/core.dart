// ignore: unnecessary_library_name
library core;

import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'utils/extensions/list_ext.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configs/values/assets.gen.dart';
import 'constants/api_constants.dart';
import 'data/models/token_model.dart';
import 'di/di.dart';
import 'localization/app_language_type.dart';
import 'localization/l10n/app_localizations.dart';
import 'localization/l10n/app_localizations_ar.dart';
import 'utils/picker/io_file_utils.dart';

// Foundation
part 'foundation/async.dart';
part 'foundation/i_use_case.dart';
part 'foundation/typedef.dart';

// Network
part 'network/dio_helper.dart';
part 'network/header_interceptor.dart';
part 'network/un_authenticated_interceptor.dart';

// Errors
part 'network/errors/exceptions.dart';
part 'network/errors/failures.dart';
part 'network/errors/status_code.dart';
part 'network/errors/failure_collect.dart';
part 'network/errors/execption_collect.dart';

// Localization
part 'localization/localization_container.dart';

// BLOC
part 'blocs/app_auth_bloc/app_authentication_bloc.dart';
part 'blocs/app_auth_bloc/app_authentication_events.dart';
part 'blocs/app_auth_bloc/app_authentication_states.dart';
part 'blocs/language_cubit/app_language_cubit.dart';
part 'blocs/language_cubit/app_language_state.dart';
part 'blocs/theme_notifier/theme_notifier.dart';

// Values
part 'configs/values/text_styles.dart';
part 'configs/values/fonts.dart';
part 'configs/values/dimensions.dart';
part 'configs/values/colors.dart';
part 'configs/values/assets_getters.dart';

// Configs
part 'configs/theme/app_theme.dart';
part 'configs/theme/dark_theme.dart';
part 'configs/theme/light_theme.dart';

// Router
part 'configs/router/app_router.dart';
part 'configs/router/animated_routes.dart';
part 'configs/router/app_scaled_box.dart';

// Data
part 'data/data_source/language_cache_date_source.dart';
part 'data/data_source/secure_storage_data_source.dart';
part 'data/models/cache_user_model.dart';

// Repository
part 'data/repository/language_cache_repository_imp.dart';
part 'data/repository/secure_storage_repository_imp.dart';
part 'data/repository/theme_repository_imp.dart';

// Domain
part 'domain/entities/token_entity.dart';
part 'domain/repository/language_cache_repository.dart';
part 'domain/repository/secure_storage_repository.dart';
part 'domain/repository/theme_repository.dart';

// Entity
part 'domain/entities/cached_user_entity.dart';
part 'domain/entities/attachement.dart';

// Use Cases
part 'domain/use_cases/language/clear_language_cache_use_case.dart';
part 'domain/use_cases/language/get_cached_language_use_case.dart';
part 'domain/use_cases/language/get_device_language_use_case.dart';
part 'domain/use_cases/language/set_cached_language_use_case.dart';
part 'domain/use_cases/secure_storage/delete_all_secure_cache_use_case.dart';
part 'domain/use_cases/secure_storage/delete_cached_user_use_case.dart';
part 'domain/use_cases/secure_storage/delete_token_use_case.dart';
part 'domain/use_cases/secure_storage/get_cached_user_use_case.dart';
part 'domain/use_cases/secure_storage/get_is_user_authenticated_use_case.dart';
part 'domain/use_cases/secure_storage/get_token_use_case.dart';
part 'domain/use_cases/secure_storage/set_cached_user_use_case.dart';
part 'domain/use_cases/secure_storage/set_token_use_case.dart';



// Extensions

