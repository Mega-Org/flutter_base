import '../../domain/entity/app_conig/onboarding_entity.dart';

class ApiOnboardingModel {
  const ApiOnboardingModel({
    required this.title,
    required this.backgroundImage,
  });

  final String title;
  final String backgroundImage;

  factory ApiOnboardingModel.fromJson(Map<String, dynamic> json) {
    return ApiOnboardingModel(
      title: json['title']?.toString() ?? '',
      backgroundImage:
          json['background_image']?.toString() ?? json['image']?.toString() ?? '',
    );
  }

  OnboardingEntity toEntity() => OnboardingEntity(
        title: title,
        backgroundImage: backgroundImage,
      );
}
