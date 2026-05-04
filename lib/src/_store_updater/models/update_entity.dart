part of '../store_updater.dart';

class UpdateEntity extends Equatable {
  final bool isEnabled;
  final bool isForceUpdate;
  final String minVersion;

  const UpdateEntity({
    required this.isEnabled,
    required this.isForceUpdate,
    required this.minVersion,
  });

  factory UpdateEntity.empty() {
    return const UpdateEntity(
      isEnabled: false,
      isForceUpdate: false,
      minVersion: '0.0.0',
    );
  }

  factory UpdateEntity.fromJson(Map<String, dynamic> json) {
    return UpdateEntity(
      isEnabled: json['is_enabled'] ?? false,
      isForceUpdate: json['force_update'] ?? false,
      minVersion: json['min_version'] ?? '0.0.0',
    );
  }

  bool get canUpdate {
    return isEnabled && minVersion != '0.0.0';
  }

  @override
  List<Object?> get props => [
        isEnabled,
        isForceUpdate,
        minVersion,
      ];

  @override
  String toString() {
    return '[StoreUpdater] ::: UpdateEntity(isEnabled: $isEnabled, isForceUpdate: $isForceUpdate, minVersion: $minVersion)';
  }
}
