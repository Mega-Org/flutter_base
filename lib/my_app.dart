import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/localization/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/core.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../core/di/di.dart';
import 'src/main_page/main_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      breakpoints: const [
        Breakpoint(start: 0, end: 450, name: MOBILE),
        Breakpoint(start: 451, end: 800, name: TABLET),
        Breakpoint(start: 801, end: 1920, name: DESKTOP),
        Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppLanguageCubit()..init()),
        ],
        child: BlocBuilder<AppLanguageCubit, AppLanguageState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                if (FocusManager.instance.primaryFocus?.hasPrimaryFocus ==
                    true) {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                }
              },
              child: ThemeBuilder(
                builder: (context, _, theme) {
                  return MaterialApp(
                    key: ValueKey(state.langCode.value + theme.name),
                    title: AppLocalizations.of(context).appName,
                    navigatorKey: appNavigatorKey,
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    locale: state.langCode.local,
                    themeMode: theme.themeMode,
                    theme: const LightTheme().theme,
                    darkTheme: const DarkTheme().theme,
                    navigatorObservers: [routeAwareObserver],
                    builder: (context, child) {
                      injector<LocalizationContainer>().setLocalizer(context);
                      return Overlay(
                        initialEntries: [
                          OverlayEntry(
                            builder: (context) =>
                                AppScaledBox(child: child ?? const SizedBox()),
                          ),
                        ],
                      );
                    },
                    home: _BuilderScreen(key: ValueKey(state.langCode.value)),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BuilderScreen extends StatelessWidget {
  const _BuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppAuthenticationBloc, AppAuthenticationState>(
      listener: (context, state) {},
      builder: (context, state) {
        final Widget root;
        if (state is AuthUninitialized) {
          root = const SizedBox();
        } else if (state is AuthUnauthenticated) {
          // root = const OnboardingPage();
          root = const SizedBox();
        } else if (state is AuthLogInPageState || state is AuthLogOutState) {
          // root = const LoginPage();
          root = const SizedBox();
        } else {
          root = const MainPage();
        }

        return Material(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            key: ValueKey(state.runtimeType),
            child: Container(
              color: Colors.white,
              key: ValueKey(state.hashCode),
              child: root,
            ),
          ),
        );
      },
    );
  }
}
