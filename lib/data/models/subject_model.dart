import 'package:equatable/equatable.dart';

class SubjectModel extends Equatable {
  const SubjectModel({
    required this.id,
    required this.nameMn,
    this.nameEn,
    required this.classGrade,
    this.iconName,
  });

  final String id;
  final String nameMn;
  final String? nameEn;
  final int classGrade;
  final String? iconName;

  @override
  List<Object?> get props => [id, nameMn, nameEn, classGrade, iconName];
}
