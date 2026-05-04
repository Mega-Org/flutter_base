import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/core.dart';

import '../../domain/entity/app_conig/onboarding_entity.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState.initial()) {
    _load();
  }

  void _load() {
    emit(state.copyWith(dataState: const Async.loading()));
    emit(state.copyWith(
      dataState: const Async.success(<OnboardingEntity>[]),
    ));
  }

  @override
  void emit(OnboardingState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
