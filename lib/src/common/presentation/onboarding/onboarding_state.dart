part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  const OnboardingState({required this.dataState});

  final Async<List<OnboardingEntity>> dataState;

  const OnboardingState.initial()
      : this(dataState: const Async.initial());

  bool get isLoading => dataState.isLoading;

  bool get isSuccess => dataState.isSuccess;

  bool get isFailure => dataState.isFailure;

  List<OnboardingEntity>? get data => dataState.data;

  OnboardingState copyWith({
    Async<List<OnboardingEntity>>? dataState,
  }) {
    return OnboardingState(
      dataState: dataState ?? this.dataState,
    );
  }

  @override
  List<Object?> get props => [dataState];
}
