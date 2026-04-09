import 'package:equatable/equatable.dart';

class HistoryItemModel extends Equatable {
  const HistoryItemModel({
    required this.id,
    required this.titleMn,
    this.completedAt,
  });

  final String id;
  final String titleMn;
  final DateTime? completedAt;

  @override
  List<Object?> get props => [id, titleMn, completedAt];
}