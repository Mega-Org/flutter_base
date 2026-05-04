import 'package:equatable/equatable.dart';

class OnboardingEntity extends Equatable {
  const OnboardingEntity({
    required this.title,
    required this.backgroundImage,
  });

  final String title;
  final String backgroundImage;

  @override
  List<Object?> get props => [title, backgroundImage];
}
