import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/data/grade_lessons_data.dart';
import '../models/subject_model.dart';
import '../models/unit_model.dart';

class LessonRepository {
  final _supabase = Supabase.instance.client;

  Future<List<SubjectModel>> getSubjectsByClass(int classGrade) async {
    final gradeData = GradeLessonsData.lessonsByGrade[classGrade] ?? {};
    return gradeData.keys
        .map(
          (subjectName) => SubjectModel(
            id: _subjectId(classGrade, subjectName),
            nameMn: subjectName,
            classGrade: classGrade,
          ),
        )
        .toList();
  }

  Future<List<SubjectModel>> getAllSubjects() async {
    final all = <SubjectModel>[];
    for (final grade in GradeLessonsData.lessonsByGrade.keys) {
      all.addAll(await getSubjectsByClass(grade));
    }
    return all;
  }

  Future<List<UnitModel>> getUnitsBySubject(String subjectId) async {
    final parts = subjectId.split('_');
    if (parts.length < 2) return [];

    final grade = int.tryParse(parts[0].replaceAll('grade', '')) ?? 0;
    final subjectName = parts.sublist(1).join('_');
    final topics = GradeLessonsData.lessonsByGrade[grade]?[subjectName] ?? [];
    if (topics.isEmpty) return [];

    final completedIds = await _getCompletedNodeIds();
    final units = <UnitModel>[];
    const chunkSize = 5;

    for (int u = 0; u < topics.length; u += chunkSize) {
      final end = (u + chunkSize < topics.length) ? (u + chunkSize) : topics.length;
      final chunkTopics = topics.sublist(u, end);
      final unitNumber = (u ~/ chunkSize) + 1;

      final nodes = chunkTopics.asMap().entries.map((e) {
        final nodeId = _nodeId(subjectId, unitNumber, e.key);
        final prevNodeId = e.key == 0 ? null : _nodeId(subjectId, unitNumber, e.key - 1);
        final isCompleted = completedIds.contains(nodeId);
        final isLocked = e.key == 0 && unitNumber == 1
            ? false
            : prevNodeId != null
                ? !completedIds.contains(prevNodeId)
                : unitNumber > 1;

        return LessonNodeModel(
          id: nodeId,
          title: e.value,
          type: e.key == chunkTopics.length - 1 ? 'test' : 'lesson',
          isLocked: isLocked,
          isCompleted: isCompleted,
        );
      }).toList();

      units.add(
        UnitModel(
          id: '${subjectId}_u$unitNumber',
          subjectId: subjectId,
          unitNumber: unitNumber,
          title: 'Нэгж $unitNumber',
          lessonCount: chunkTopics.length - 1,
          testCount: 1,
          nodes: nodes,
        ),
      );
    }

    return units;
  }

  Future<Set<String>> _getCompletedNodeIds() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return {};
      final data = await _supabase
          .from('lesson_progress')
          .select('node_id')
          .eq('user_id', userId)
          .eq('is_completed', true);
      return (data as List).map((e) => e['node_id'] as String).toSet();
    } catch (_) {
      return {};
    }
  }

  static String _subjectId(int grade, String subjectName) => 'grade${grade}_$subjectName';

  static String _nodeId(String subjectId, int unitNumber, int topicIndex) =>
      '${subjectId}_u${unitNumber}_t$topicIndex';

  static String nodeIdFor({
    required int grade,
    required String subjectName,
    required int unitNumber,
    required int topicIndex,
  }) {
    final sid = _subjectId(grade, subjectName);
    return _nodeId(sid, unitNumber, topicIndex);
  }
}
