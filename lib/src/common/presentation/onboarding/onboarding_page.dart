import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/core.dart';
import 'package:flutter_base/material/media/app_image.dart';
import 'package:flutter_base/material/media/svg_icon.dart';
import 'package:flutter_base/material/shimmer/shimmer_effect_widget.dart';

import '../../domain/entity/app_conig/onboarding_entity.dart';
import '../change_language/change_language_bottom_sheet.dart';
import 'onboarding_cubit.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final Widget child;
        final List<OnboardingEntity> data = state.data ?? [];
        if (state.isLoading) {
          child = const _LoadingShimmer();
        } else if (state.isSuccess) {
          child = _OnboardingPageBody(data: data);
        } else if (state.isFailure) {
          child = _OnboardingPageBody(data: data);
        } else {
          child = const SizedBox();
        }

        return Scaffold(
          body: child,
        );
      },
    );
  }
}

class _OnboardingPageBody extends StatefulWidget {
  const _OnboardingPageBody({
    required this.data,
  });

  final List<OnboardingEntity> data;

  @override
  State<_OnboardingPageBody> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<_OnboardingPageBody> {
  int _currentPage = 0;
  List<Widget> get _textWidgets =>
      data.map((item) => _TextWidget(text: item.title)).toList();
  final List<Widget> _imagesWidgets = [];

  void _setWidgetsData() {
    for (OnboardingEntity item in data) {
      _imagesWidgets.add(AppImage(
        path: item.backgroundImage,
        height: double.infinity,
        width: double.infinity,
        cacheImage: true,
      ));
    }
  }

  List<OnboardingEntity> get data => widget.data;
  int get _kOnbordingPageCount => widget.data.length;
  bool get getIsLastPage => _currentPage == _kOnbordingPageCount - 1;
  bool get getIsFirstPage => _currentPage == 0;

  void _onNext() {
    if (getIsLastPage) {
      _onFinish();
    } else {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _onPrevious() {
    if (!getIsFirstPage) {
      setState(() {
        _currentPage--;
      });
    }
  }

  void _onFinish() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    AppAuthenticationBloc.of(context).add(const OnFinishWalkthroughEvent());
  }

  void _manageOnNoData() {
    if (data.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onFinish();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _setWidgetsData();
    _manageOnNoData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_imagesWidgets.isNotEmpty)
          AnimatedSwitcher(
            duration: Durations.medium2,
            reverseDuration: Durations.medium4,
            child: SizedBox(
              key: ValueKey(_currentPage),
              child: _imagesWidgets[_currentPage],
            ),
          ),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [.1, .9, 1],
            colors: [
              Colors.black12,
              Colors.black87,
              Colors.black,
            ],
          )),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _HeaderWidget(
                  onSkip: _onFinish,
                  canSkip: !getIsLastPage,
                ),
                const SizedBox(height: 32),
                if (_textWidgets.isNotEmpty)
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedSwitcher(
                        duration: Durations.medium4,
                        reverseDuration: Durations.medium4,
                        child: SizedBox(
                          key: ValueKey(_currentPage),
                          child: _textWidgets[_currentPage],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 32),
                Row(
                  spacing: 6,
                  children: [
                    if (!getIsFirstPage)
                      _ActionButton(
                        icon: Icons.arrow_back,
                        onTap: _onPrevious,
                      ),
                    Expanded(
                      child: _PageProgressInductor(
                        currentPage: _currentPage,
                        count: _kOnbordingPageCount,
                      ),
                    ),
                    _ActionButton(
                      icon: Icons.arrow_forward,
                      onTap: _onNext,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white30),
        ),
        padding: const EdgeInsets.all(16),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

class _PageProgressInductor extends StatelessWidget {
  const _PageProgressInductor({
    required this.currentPage,
    required this.count,
  });
  final int currentPage;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          currentPage == 0 ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final bool isSelected = index == currentPage;
        return AnimatedContainer(
          duration: Durations.medium2,
          height: 3,
          width: isSelected ? 50 : 30,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected ? Colors.white : Colors.white54,
          ),
        );
      }),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    required this.onSkip,
    required this.canSkip,
  });

  final VoidCallback onSkip;
  final bool canSkip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (canSkip)
            ? GestureDetector(
                onTap: onSkip,
                behavior: HitTestBehavior.opaque,
                child: Text(
                  "",
                  style: TextStyles.light14.copyWith(color: Colors.white),
                ),
              )
            : const SizedBox(),
        GestureDetector(
          onTap: () {
            ChangeLanguageBottomSheet.show(context);
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            spacing: 4,
            children: [
              AppSvgIcon(path: AppIcons.trash),
              BlocBuilder<AppLanguageCubit, AppLanguageState>(
                builder: (context, state) {
                  return Text(
                    "",
                    style: TextStyles.light14.copyWith(color: Colors.white),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TextWidget extends StatelessWidget {
  const _TextWidget({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyles.regular24.copyWith(color: Colors.white),
    );
  }
}

class _LoadingShimmer extends StatelessWidget {
  const _LoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          ShimmerWidget(
            child: Container(
              color: Colors.black,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          ShimmerWidget(
            startColor: Colors.black12,
            endColor: Colors.black87,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _HeaderWidget(
                      onSkip: () {},
                      canSkip: true,
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                            spacing: 8,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: List.generate(
                              3,
                              (index) {
                                return Container(
                                  width: MediaQuery.of(context).size.width *
                                      (1 - (index * .15)),
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                );
                              },
                            )),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      spacing: 6,
                      children: [
                        const Expanded(
                          child: _PageProgressInductor(
                            currentPage: 0,
                            count: 3,
                          ),
                        ),
                        _ActionButton(
                          icon: Icons.arrow_forward,
                          onTap: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
