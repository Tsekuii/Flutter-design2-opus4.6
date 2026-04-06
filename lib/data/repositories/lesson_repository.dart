import '../models/subject_model.dart';
import '../models/unit_model.dart';

/// Lessons by class and subject. Mock data for frontend.
class LessonRepository {
  final List<SubjectModel> _subjects = [
    const SubjectModel(id: 'math', nameMn: 'Математик', classGrade: 10),
    const SubjectModel(id: 'physics', nameMn: 'Физик', classGrade: 10),
    const SubjectModel(id: 'mongolian', nameMn: 'Монгол хэл', classGrade: 10),
    const SubjectModel(id: 'english', nameMn: 'Англи хэл', classGrade: 10),
    const SubjectModel(id: 'history', nameMn: 'Түүх', classGrade: 10),
    const SubjectModel(id: 'informatics', nameMn: 'Мэдээлэл зүй', classGrade: 10),
  ];

  Future<List<SubjectModel>> getSubjectsByClass(int classGrade) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _subjects.where((s) => s.classGrade == classGrade).toList();
  }

  Future<List<SubjectModel>> getAllSubjects() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_subjects);
  }

  Future<List<UnitModel>> getUnitsBySubject(String subjectId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (subjectId == 'math') {
      return [
        UnitModel(
          id: 'math-u1',
          subjectId: subjectId,
          unitNumber: 1,
          title: 'ФУНКЦ БА ГРАФИК',
          lessonCount: 6,
          testCount: 2,
          nodes: const [
            LessonNodeModel(id: 'n1', title: 'Шууд пропорционал хамаарал', type: 'lesson', isLocked: false, isCompleted: true),
            LessonNodeModel(id: 'n2', title: 'Урвуу пропорционал хамаарал', type: 'lesson', isLocked: false, isCompleted: false),
            LessonNodeModel(id: 'n3', title: 'Графикийн онцлог', type: 'lesson', isLocked: true, isCompleted: false),
            LessonNodeModel(id: 'n4', title: 'Дасгал даалгавар', type: 'exercise', isLocked: true, isCompleted: false),
            LessonNodeModel(id: 'n5', title: 'Нэгж 1 - Шалгалт', type: 'test', isLocked: true, isCompleted: false),
          ],
        ),
        UnitModel(
          id: 'math-u2',
          subjectId: subjectId,
          unitNumber: 2,
          title: 'ТРИГОНОМЕТР',
          lessonCount: 5,
          testCount: 1,
          nodes: const [],
        ),
      ];
    }
    return [
      UnitModel(
        id: '$subjectId-u1',
        subjectId: subjectId,
        unitNumber: 1,
        title: 'Нэгж 1',
        lessonCount: 5,
        testCount: 1,
        nodes: const [],
      ),
    ];
  }
}
