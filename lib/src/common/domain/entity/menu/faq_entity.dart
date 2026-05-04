import 'package:equatable/equatable.dart';

class FaqEntity extends Equatable {
  final int id;
  final String name;
  final String description;

  const FaqEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, description];
}
