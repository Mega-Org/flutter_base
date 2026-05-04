import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/core.dart';
import 'package:flutter_base/material/loading/app_loading_widget.dart';
import 'package:flutter_base/material/media/svg_icon.dart';
import 'package:flutter_base/material/overlay/show_modal_bottom_sheet.dart';
import 'package:flutter_base/material/toast/app_toast.dart';

import 'change_language_cubit.dart';

class ChangeLanguageBottomSheet extends StatefulWidget {
  const ChangeLanguageBottomSheet._();

  @override
  State<ChangeLanguageBottomSheet> createState() =>
      _ChangeLanguageBottomSheetState();

  static Future<void> show(BuildContext context) async {
    await showAppModalBottomSheet<void>(
      child: BlocProvider(
        create: (context) => ChangeLanguageCubit(),
        child: const ChangeLanguageBottomSheet._(),
      ),
      context: context,
    );
  }
}

class _ChangeLanguageBottomSheetState extends State<ChangeLanguageBottomSheet> {
  AppLanguageEnum currentLang = AppLanguageEnum.en;

  AppLanguageEnum get savedLanguage =>
      AppLanguageCubit.of(context).state.langCode;

  bool get isUserLogin =>
      AppAuthenticationBloc.of(context).state is AuthAuthenticatedState;

  @override
  void initState() {
    currentLang = savedLanguage;
    super.initState();
  }

  void _onLanguageChange(AppLanguageEnum selectedLang) {
    if (isUserLogin) {
      context.read<ChangeLanguageCubit>().changeLanguage(selectedLang);
    } else {
      _onSaveLanguage();
    }
  }

  void _onSaveLanguage() async {
    switch (currentLang) {
      case AppLanguageEnum.ar:
        currentLang = AppLanguageEnum.en;
      case AppLanguageEnum.en:
        currentLang = AppLanguageEnum.ar;
    }
    if (savedLanguage != currentLang) {
      AppLanguageCubit.of(context).changeLanguage(currentLang);
    }
    if (mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
    if (mounted && savedLanguage != currentLang) {
      await Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          AppAuthenticationBloc.of(context).add(const AuthRestartEvent());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangeLanguageCubit, ChangeLanguageState>(
      listener: (context, state) {
        if (state.isLoading) {
          AppLoadingWidget.overlay();
        } else if (state.isSuccess) {
          AppLoadingWidget.removeOverlay();
          _onSaveLanguage();
        } else if (state.isFailure) {
          AppLoadingWidget.removeOverlay();
          AppToasts.error(context, message: state.errorMessage ?? '');
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "",
            style: TextStyles.regular16.copyWith(color: AppColors.text),
          ),
          const SizedBox(height: 24),
          _Tile(
            groupValue: currentLang,
            value: AppLanguageEnum.ar,
            icon: AppIcons.trash,
            onTap: _onLanguageChange,
            title: "العربية",
          ),
          const Divider(),
          _Tile(
            value: AppLanguageEnum.en,
            groupValue: currentLang,
            icon: AppIcons.trash,
            onTap: _onLanguageChange,
            title: "English",
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.onTap,
    required this.title,
    required this.icon,
    required this.value,
    required this.groupValue,
  });
  final AppLanguageEnum value;
  final AppLanguageEnum groupValue;
  final ValueChanged<AppLanguageEnum> onTap;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: () {
        onTap(value);
      },
      child: Row(
        spacing: 6,
        children: [
          AppSvgIcon(path: icon),
          Expanded(
            child: Text(
              title,
              style: TextStyles.light14.copyWith(color: AppColors.text),
            ),
          ),
          Radio<AppLanguageEnum>(
            value: value,
            toggleable: true,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            groupValue: groupValue,
            onChanged: (value) {
              onTap(value ?? this.value);
            },
          ),
        ],
      ),
    );
  }
}
