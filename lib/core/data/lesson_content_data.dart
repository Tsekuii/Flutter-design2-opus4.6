// ignore_for_file: unused_element

import 'dart:math';
import 'legacy_question_bank.dart';

enum LessonQuizType { multipleChoice, shortAnswer, trueFalse }

class LessonQuestion {
  const LessonQuestion._({
    required this.type,
    required this.promptMn,
    required this.promptEn,
    this.choicesMn,
    this.choicesEn,
    this.correctChoiceIndex,
    this.correctTrueFalse,
    this.expectedAnswers,
    this.answerMn,
    this.answerEn,
  });

  factory LessonQuestion.multipleChoice({
    required String promptMn,
    required String promptEn,
    required List<String> choicesMn,
    required List<String> choicesEn,
    required int correctIndex,
    String? answerMn,
    String? answerEn,
  }) {
    return LessonQuestion._(
      type: LessonQuizType.multipleChoice,
      promptMn: promptMn,
      promptEn: promptEn,
      choicesMn: choicesMn,
      choicesEn: choicesEn,
      correctChoiceIndex: correctIndex,
      answerMn: answerMn,
      answerEn: answerEn,
    );
  }

  factory LessonQuestion.shortAnswer({
    required String promptMn,
    required String promptEn,
    required List<String> expectedAnswers,
    String? answerMn,
    String? answerEn,
  }) {
    return LessonQuestion._(
      type: LessonQuizType.shortAnswer,
      promptMn: promptMn,
      promptEn: promptEn,
      expectedAnswers: expectedAnswers,
      answerMn: answerMn,
      answerEn: answerEn,
    );
  }

  factory LessonQuestion.trueFalse({
    required String promptMn,
    required String promptEn,
    required bool correct,
    String? answerMn,
    String? answerEn,
  }) {
    return LessonQuestion._(
      type: LessonQuizType.trueFalse,
      promptMn: promptMn,
      promptEn: promptEn,
      correctTrueFalse: correct,
      answerMn: answerMn,
      answerEn: answerEn,
    );
  }

  final LessonQuizType type;

  final String promptMn;
  final String promptEn;

  // MCQ
  final List<String>? choicesMn;
  final List<String>? choicesEn;
  final int? correctChoiceIndex;

  // True/False
  final bool? correctTrueFalse;

  // Short answer
  final List<String>? expectedAnswers; // normalized accepted answers

  // Shown answer text (optional, used by UI)
  final String? answerMn;
  final String? answerEn;
}

class LessonContent {
  const LessonContent({
    required this.explainMn,
    required this.explainEn,
    required this.question,
    this.questions = const [],
  });

  final String explainMn;
  final String explainEn;
  final LessonQuestion question;
  final List<LessonQuestion> questions;
}

class LessonContentData {
  const LessonContentData._();

  static LessonContent build({
    required int grade,
    required String subject,
    required String topic,
    required LessonQuizType quizType,
  }) {
    final seed = _seedFor(grade: grade, subject: subject, topic: topic);
    final rng = Random(seed);
    final legacy = LegacyQuestionBank.questionsFor(grade: grade, subject: subject);
    final explainMn = _explainMn(grade: grade, subject: subject, topic: topic, rng: rng);
    final explainEn = _explainEn(grade: grade, subject: subject, topic: topic, rng: rng);

    // Strict mode: always use fixed legacy question bank.
    // No generated/random fallback should be shown to users.
    if (legacy.isNotEmpty) {
      return LessonContent(
        explainMn: explainMn,
        explainEn: explainEn,
        question: legacy.first,
        questions: legacy,
      );
    }

    final fallback = <LessonQuestion>[
      LessonQuestion.shortAnswer(
        promptMn: '$grade-р анги, $subject: "$topic" сэдвээр 2-3 өгүүлбэрээр тайлбар бич.',
        promptEn: 'Grade $grade, $subject: Write 2-3 sentences about "$topic".',
        expectedAnswers: const [' '],
        answerMn: 'Чөлөөт хариу.',
        answerEn: 'Open response.',
      ),
    ];
    return LessonContent(
      explainMn: explainMn,
      explainEn: explainEn,
      question: fallback.first,
      questions: fallback,
    );
  }
}

List<LessonQuestion> _legacyQuestionsFor({required int grade, required String subject}) {
  final s = subject.toLowerCase();
  final isMn = subject.contains('Монгол') || s.contains('mongol');
  final isMath = subject.contains('Математик') || s.contains('math');
  final isEn = subject.contains('Англи') || s.contains('english');
  final isNature = subject.contains('Байгаль') || s.contains('nature');
  final isArt = subject.contains('Дүрслэх') || s.contains('art');
  final isMusic = subject.contains('Хөгжим') || s.contains('music');
  final isPhysics = subject.contains('Физик') || s.contains('physics');
  final isChem = subject.contains('Хими') || s.contains('chem');
  final isBio = subject.contains('Биологи') || s.contains('bio');
  final isSoc = subject.contains('Нийгэм') || subject.contains('Түүх') || s.contains('social') || s.contains('history');

  if (grade == 1 && isMn) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: '“А” үсгээр эхэлдэг үг аль нь вэ?',
        promptEn: 'Which word starts with "A"?',
        choicesMn: const ['алим', 'ном', 'морь'],
        choicesEn: const ['alim', 'book', 'horse'],
        correctIndex: 0,
        answerMn: 'Зөв: алим',
        answerEn: 'Correct: alim',
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Эгшиг үсэг аль нь вэ?',
        promptEn: 'Which is a vowel?',
        choicesMn: const ['б', 'а', 'м'],
        choicesEn: const ['b', 'a', 'm'],
        correctIndex: 1,
        answerMn: 'Зөв: а',
        answerEn: 'Correct: a',
      ),
      LessonQuestion.shortAnswer(
        promptMn: 'Өгүүлбэр зохио.',
        promptEn: 'Write one sentence.',
        expectedAnswers: const [' '],
        answerMn: 'Чөлөөт хариу.',
        answerEn: 'Open response.',
      ),
    ];
  }
  if (grade == 1 && isMath) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: '2 + 3 = ?',
        promptEn: '2 + 3 = ?',
        choicesMn: const ['5', '6', '4'],
        choicesEn: const ['5', '6', '4'],
        correctIndex: 0,
        answerMn: 'Зөв: 5',
        answerEn: 'Correct: 5',
      ),
      LessonQuestion.multipleChoice(
        promptMn: '7 - 2 = ?',
        promptEn: '7 - 2 = ?',
        choicesMn: const ['6', '5', '3'],
        choicesEn: const ['6', '5', '3'],
        correctIndex: 1,
        answerMn: 'Зөв: 5',
        answerEn: 'Correct: 5',
      ),
      LessonQuestion.multipleChoice(
        promptMn: '10-аас их тоо аль вэ?',
        promptEn: 'Which number is greater than 10?',
        choicesMn: const ['8', '12', '5'],
        choicesEn: const ['8', '12', '5'],
        correctIndex: 1,
        answerMn: 'Зөв: 12',
        answerEn: 'Correct: 12',
      ),
    ];
  }
  if (grade == 1 && isNature) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: 'Аль нь амьтан вэ?',
        promptEn: 'Which is an animal?',
        choicesMn: const ['нохой', 'мод', 'чулуу'],
        choicesEn: const ['dog', 'tree', 'stone'],
        correctIndex: 0,
        answerMn: 'Зөв: нохой',
        answerEn: 'Correct: dog',
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Өвөл ямар вэ?',
        promptEn: 'What is winter like?',
        choicesMn: const ['халуун', 'хүйтэн', 'бороотой'],
        choicesEn: const ['hot', 'cold', 'rainy'],
        correctIndex: 1,
        answerMn: 'Зөв: хүйтэн',
        answerEn: 'Correct: cold',
      ),
    ];
  }

  if (grade == 2 && isMn) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: 'Аль нь зөв өгүүлбэр вэ?',
        promptEn: 'Which sentence is correct?',
        choicesMn: const ['Би ном уншина.', 'ном би уншина', 'уншина би ном'],
        choicesEn: const ['I read a book.', 'book I read', 'read I book'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Уншаад ойлгох нь…',
        promptEn: 'Reading with understanding is...',
        choicesMn: const ['чухал', 'хэрэггүй', 'хэцүү'],
        choicesEn: const ['important', 'useless', 'hard'],
        correctIndex: 0,
      ),
    ];
  }
  if (grade == 2 && isMath) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: '25 + 10 = ?',
        promptEn: '25 + 10 = ?',
        choicesMn: const ['35', '30', '40'],
        choicesEn: const ['35', '30', '40'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '60 - 20 = ?',
        promptEn: '60 - 20 = ?',
        choicesMn: const ['50', '40', '30'],
        choicesEn: const ['50', '40', '30'],
        correctIndex: 1,
      ),
    ];
  }
  if (grade == 2 && isEn) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: '"Red" юу вэ?',
        promptEn: 'What is "Red"?',
        choicesMn: const ['өнгө', 'амьтан', 'тоо'],
        choicesEn: const ['color', 'animal', 'number'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '"One" гэж?',
        promptEn: '"One" means?',
        choicesMn: const ['1', '2', '3'],
        choicesEn: const ['1', '2', '3'],
        correctIndex: 0,
      ),
    ];
  }

  if (grade == 3 && isMath) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: '4 × 5 = ?',
        promptEn: '4 × 5 = ?',
        choicesMn: const ['20', '25', '15'],
        choicesEn: const ['20', '25', '15'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '15 ÷ 3 = ?',
        promptEn: '15 ÷ 3 = ?',
        choicesMn: const ['5', '3', '6'],
        choicesEn: const ['5', '3', '6'],
        correctIndex: 0,
      ),
    ];
  }
  if (grade == 3 && isEn) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: 'Аль өгүүлбэр зөв вэ?',
        promptEn: 'Which sentence is correct?',
        choicesMn: const ['I like apples.', 'Like I apples', 'Apples I like'],
        choicesEn: const ['I like apples.', 'Like I apples', 'Apples I like'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '"Blue" ямар утгатай вэ?',
        promptEn: 'What does "Blue" mean?',
        choicesMn: const ['өнгө', 'амьтан', 'үйлдэл'],
        choicesEn: const ['color', 'animal', 'action'],
        correctIndex: 0,
      ),
    ];
  }

  if (grade == 4 && isMath) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: '6 × 7 = ?',
        promptEn: '6 × 7 = ?',
        choicesMn: const ['42', '36', '48'],
        choicesEn: const ['42', '36', '48'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '56 ÷ 8 = ?',
        promptEn: '56 ÷ 8 = ?',
        choicesMn: const ['7', '6', '8'],
        choicesEn: const ['7', '6', '8'],
        correctIndex: 0,
      ),
    ];
  }
  if (grade == 4 && isSoc) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: 'Монгол нутаг хаана байрладаг вэ?',
        promptEn: 'Where is Mongolia located?',
        choicesMn: const ['Төв Азид', 'Африк', 'Европ'],
        choicesEn: const ['Central Asia', 'Africa', 'Europe'],
        correctIndex: 0,
      ),
    ];
  }

  if (grade == 5 && isMath) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: '3/4 + 1/4 = ?',
        promptEn: '3/4 + 1/4 = ?',
        choicesMn: const ['1', '3/8', '1/2'],
        choicesEn: const ['1', '3/8', '1/2'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '50% нь хэд вэ?',
        promptEn: 'What is 50%?',
        choicesMn: const ['25', '50', '10'],
        choicesEn: const ['25', '50', '10'],
        correctIndex: 0,
      ),
    ];
  }
  if (grade == 6 && isMath) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: '20% нь хэд вэ?',
        promptEn: 'What is 20% of 20?',
        choicesMn: const ['4', '10', '5'],
        choicesEn: const ['4', '10', '5'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Харьцаа: 2:5 = ?',
        promptEn: 'Ratio 2:5 equals?',
        choicesMn: const ['2/5', '5/2', '3/5'],
        choicesEn: const ['2/5', '5/2', '3/5'],
        correctIndex: 0,
      ),
    ];
  }
  if (grade == 7 && isMath) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: '2x + 5 = 15 → x=?',
        promptEn: '2x + 5 = 15 → x=?',
        choicesMn: const ['5', '10', '15'],
        choicesEn: const ['5', '10', '15'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'y = x + 2, x=3 → y=?',
        promptEn: 'y = x + 2, x=3 → y=?',
        choicesMn: const ['5', '6', '3'],
        choicesEn: const ['5', '6', '3'],
        correctIndex: 0,
      ),
    ];
  }
  if (grade == 8 && isMath) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: '5x - 7 = 18 → x=?',
        promptEn: '5x - 7 = 18 → x=?',
        choicesMn: const ['5', '4', '6'],
        choicesEn: const ['5', '4', '6'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '7 × 8 = ?',
        promptEn: '7 × 8 = ?',
        choicesMn: const ['56', '54', '58'],
        choicesEn: const ['56', '54', '58'],
        correctIndex: 0,
      ),
    ];
  }
  if (grade == 9 && isMath) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: '2x + 5 = 17 → x=?',
        promptEn: '2x + 5 = 17 → x=?',
        choicesMn: const ['6', '5', '7'],
        choicesEn: const ['6', '5', '7'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '√49 = ?',
        promptEn: '√49 = ?',
        choicesMn: const ['7', '6', '8'],
        choicesEn: const ['7', '6', '8'],
        correctIndex: 0,
      ),
    ];
  }
  if (grade == 10 && isMath) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: '3x - 7 = 11 → x=?',
        promptEn: '3x - 7 = 11 → x=?',
        choicesMn: const ['6', '5', '7'],
        choicesEn: const ['6', '5', '7'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'y = 2x + 3, x=4 → y=?',
        promptEn: 'y = 2x + 3, x=4 → y=?',
        choicesMn: const ['11', '10', '12'],
        choicesEn: const ['11', '10', '12'],
        correctIndex: 0,
      ),
    ];
  }
  if (grade == 11 && isMath) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: '2^x = 32 → x=?',
        promptEn: '2^x = 32 → x=?',
        choicesMn: const ['5', '4', '6'],
        choicesEn: const ['5', '4', '6'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'log₂8 = ?',
        promptEn: 'log₂8 = ?',
        choicesMn: const ['3', '2', '4'],
        choicesEn: const ['3', '2', '4'],
        correctIndex: 0,
      ),
    ];
  }
  if (grade == 12 && isMath) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: 'sin(x)-ийн уламжлал аль нь вэ?',
        promptEn: 'Derivative of sin(x)?',
        choicesMn: const ['cos(x)', 'sin(x)', '-cos(x)'],
        choicesEn: const ['cos(x)', 'sin(x)', '-cos(x)'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '∫(2x dx) = ?',
        promptEn: '∫(2x dx) = ?',
        choicesMn: const ['x² + C', '2x² + C', 'x + C'],
        choicesEn: const ['x² + C', '2x² + C', 'x + C'],
        correctIndex: 0,
      ),
    ];
  }

  if (isEn) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: 'Correct sentence аль нь вэ?',
        promptEn: 'Which sentence is correct?',
        choicesMn: const ['She doesn\'t like apples.', 'She don\'t like apples.', 'She not like apples.'],
        choicesEn: const ['She doesn\'t like apples.', 'She don\'t like apples.', 'She not like apples.'],
        correctIndex: 0,
      ),
      LessonQuestion.shortAnswer(
        promptMn: '2 өгүүлбэр англиар бич.',
        promptEn: 'Write 2 sentences in English.',
        expectedAnswers: const [' '],
        answerMn: 'Чөлөөт хариу.',
        answerEn: 'Open response.',
      ),
    ];
  }

  if (isPhysics || isChem || isBio || isSoc || isArt || isMusic || isNature) {
    return [
      LessonQuestion.multipleChoice(
        promptMn: '"$subject" сэдвийн ерөнхий ойлголт аль нь вэ?',
        promptEn: 'Which statement best matches "$subject"?',
        choicesMn: const ['Зөв ойлголт', 'Буруу ойлголт', 'Хамааралгүй'],
        choicesEn: const ['Correct concept', 'Incorrect concept', 'Unrelated'],
        correctIndex: 0,
      ),
      LessonQuestion.shortAnswer(
        promptMn: '"$subject" сэдвээр богино хариу бич.',
        promptEn: 'Write a short response about "$subject".',
        expectedAnswers: const [' '],
        answerMn: 'Чөлөөт хариу.',
        answerEn: 'Open response.',
      ),
    ];
  }

  return const [];
}

int _questionCountForGrade(int grade) {
  if (grade <= 4) return 4;
  if (grade <= 8) return 6;
  return 8;
}

int _difficultyForGrade(int grade) {
  if (grade <= 4) return 0;
  if (grade <= 8) return 1;
  return 2;
}

int _seedFor({required int grade, required String subject, required String topic}) {
  var h = 17;
  h = 37 * h + grade;
  for (final c in subject.codeUnits) {
    h = 37 * h + c;
  }
  for (final c in topic.codeUnits) {
    h = 37 * h + c;
  }
  return h & 0x7fffffff;
}

String _explainMn({
  required int grade,
  required String subject,
  required String topic,
  required Random rng,
}) {
  final tips = [
    'Гол санааг богино өгүүлбэрээр ойлгоорой.',
    '1–2 жишээгээр баталгаажуулж сур.',
    'Алдаа гарвал бодлогоо дахин шалга.',
    'Түлхүүр үгсээ тэмдэглэж ав.',
  ];
  final tip = tips[rng.nextInt(tips.length)];
  return 'Сэдэв: "$topic" ($grade-р анги, $subject)\n\nТайлбар:\n- Энэ сэдэв дээр бид үндсэн ойлголтыг сурна.\n- Дараа нь жишээгээр бататгана.\n\nЗөвлөгөө: $tip';
}

String _explainEn({
  required int grade,
  required String subject,
  required String topic,
  required Random rng,
}) {
  final tips = [
    'Focus on the main idea in one sentence.',
    'Confirm your understanding with 1–2 examples.',
    'If you make a mistake, re-check your steps.',
    'Write down the key words.',
  ];
  final tip = tips[rng.nextInt(tips.length)];
  return 'Topic: "$topic" (Grade $grade, $subject)\n\nExplanation:\n- Learn the core idea of this topic.\n- Then practice with a quick example.\n\nTip: $tip';
}

Iterable<int> _uniqueInts(List<int> xs) sync* {
  final seen = <int>{};
  for (final x in xs) {
    if (seen.add(x)) yield x;
  }
  // add more if needed
  var next = xs.isEmpty ? 0 : xs.first;
  while (seen.length < 10) {
    next += 3;
    if (seen.add(next)) yield next;
  }
}

String _norm(String s) => s.trim().toLowerCase();

String _capitalizeMn(String s) {
  if (s.trim().isEmpty) return s;
  final t = s.trim();
  if (t.length == 1) return t.toUpperCase();
  return t[0].toUpperCase() + t.substring(1);
}

String _swapFirstTwo(String s) {
  final t = s.trim();
  if (t.length < 2) return t;
  return t[1] + t[0] + t.substring(2);
}

