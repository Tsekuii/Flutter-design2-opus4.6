import 'package:equatable/equatable.dart';

class HistoryItemModel extends Equatable {
  const HistoryItemModel({
    required this.id,
    required this.title,
    required this.subjectName,
    required this.scorePercent,
    required this.completedAt,
  });

  final String id;
  final String title;
  final String subjectName;
  final int scorePercent;
  final DateTime completedAt;

  @override
  List<Object?> get props => [id, title, subjectName, scorePercent, completedAt];
}
