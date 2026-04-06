import 'package:equatable/equatable.dart';

class AchievementModel extends Equatable {
  const AchievementModel({
    required this.id,
    required this.titleMn,
    required this.descriptionMn,
    required this.iconName,
    this.isUnlocked = false,
  });

  final String id;
  final String titleMn;
  final String descriptionMn;
  final String iconName;
  final bool isUnlocked;

  @override
  List<Object?> get props => [id, titleMn, descriptionMn, iconName, isUnlocked];
}
