import 'package:flutter/material.dart';
import 'dart:math';
import '../../core/data/lesson_content_data.dart';
import '../../core/i18n/tr.dart';
import '../../core/theme/theme_ext.dart';
import '../../data/repositories/lesson_repository.dart';
import '../../data/service/progress_service.dart';

class LessonInteractivePage extends StatefulWidget {
  const LessonInteractivePage({
    super.key,
    required this.grade,
    required this.subject,
    required this.topic,
  });

  final int grade;
  final String subject;
  final String topic;

  @override
  State<LessonInteractivePage> createState() => _LessonInteractivePageState();
}

class _LessonInteractivePageState extends State<LessonInteractivePage> {
  final _answerCtrl = TextEditingController();
  final _progressService = ProgressService();
  final _startTime = DateTime.now();

  late final LessonQuizType _quizType;
  late final LessonContent _content;
  late final List<LessonQuestion> _questions;
  int _questionIndex = 0;
  int _correctAnswers = 0;
  bool _showAnswer = false;
  bool _checked = false;
  bool? _isCorrect;
  int? _selectedChoice;
  bool? _selectedTrueFalse;

  @override
  void initState() {
    super.initState();
    // Random each time you enter the lesson.
    _quizType = LessonQuizType.values[Random().nextInt(LessonQuizType.values.length)];
    _content = LessonContentData.build(
      grade: widget.grade,
      subject: widget.subject,
      topic: widget.topic,
      quizType: _quizType,
    );
    _questions = _content.questions.isEmpty ? [_content.question] : _content.questions;
  }

  @override
  void dispose() {
    _answerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEn = context.isEn;
    final q = _questions[_questionIndex];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: context.appSurfaceVariant,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.arrow_back_rounded, size: 20),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr('${widget.grade}-р анги • ${widget.subject}', 'Grade ${widget.grade} • ${widget.subject}'),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            widget.topic,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                _CardBlock(
                  title: context.tr('Тайлбар', 'Explanation'),
                  child: Text(
                    isEn ? _content.explainEn : _content.explainMn,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 14),

                _CardBlock(
                  title: context.tr('Асуулт', 'Question'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEn ? q.promptEn : q.promptMn,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      _QuizTypeBadge(type: _quizType),
                      const SizedBox(height: 8),
                      Text(
                        context.tr(
                          'Асуулт ${_questionIndex + 1}/${_questions.length}',
                          'Question ${_questionIndex + 1}/${_questions.length}',
                        ),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      if (_quizType == LessonQuizType.multipleChoice)
                        _MultipleChoice(
                          isEn: isEn,
                          question: q,
                          selectedIndex: _selectedChoice,
                          onChanged: (v) => setState(() {
                            _selectedChoice = v;
                            _checked = false;
                            _isCorrect = null;
                          }),
                        )
                      else if (_quizType == LessonQuizType.trueFalse)
                        _TrueFalse(
                          isEn: isEn,
                          selected: _selectedTrueFalse,
                          onChanged: (v) => setState(() {
                            _selectedTrueFalse = v;
                            _checked = false;
                            _isCorrect = null;
                          }),
                        )
                      else
                        TextField(
                          controller: _answerCtrl,
                          decoration: InputDecoration(
                            hintText: context.tr('Хариугаа бичээрэй...', 'Type your answer...'),
                          ),
                          minLines: 1,
                          maxLines: 4,
                        ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _canCheck(q)
                                  ? () {
                                      final ok = _checkAnswer(q: q);
                                      setState(() {
                                        _checked = true;
                                        _isCorrect = ok;
                                      });
                                    }
                                  : null,
                              child: Text(context.tr('Шалгах', 'Check')),
                            ),
                          ),
                        ],
                      ),
                      if (_checked && _isCorrect != null) ...[
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: (_isCorrect == true
                                    ? Colors.green
                                    : Colors.red)
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _isCorrect == true
                                ? context.tr('Зөв!', 'Correct!')
                                : context.tr('Буруу байна.', 'Not correct.'),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => setState(() => _showAnswer = !_showAnswer),
                              child: Text(
                                _showAnswer
                                    ? context.tr('Хариу нуух', 'Hide answer')
                                    : context.tr('Хариу харах', 'Show answer'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_showAnswer && (q.answerMn != null || q.answerEn != null)) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: context.appSurfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isEn ? (q.answerEn ?? '') : (q.answerMn ?? ''),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _questionIndex > 0 ? _goPrev : null,
                              child: Text(context.tr('Өмнөх асуулт', 'Previous question')),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _questionIndex + 1 < _questions.length
                                  ? _goNext
                                  : _checked
                                      ? _finishLesson
                                      : null,
                              child: Text(
                                _questionIndex + 1 < _questions.length
                                    ? context.tr('Дараагийн асуулт', 'Next question')
                                    : context.tr('Дуусгах', 'Finish'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _canCheck(LessonQuestion q) {
    switch (q.type) {
      case LessonQuizType.multipleChoice:
        return _selectedChoice != null;
      case LessonQuizType.trueFalse:
        return _selectedTrueFalse != null;
      case LessonQuizType.shortAnswer:
        return _answerCtrl.text.trim().isNotEmpty;
    }
  }

  bool _checkAnswer({required LessonQuestion q}) {
    bool correct;
    switch (q.type) {
      case LessonQuizType.multipleChoice:
        correct = _selectedChoice == q.correctChoiceIndex;
        break;
      case LessonQuizType.trueFalse:
        correct = _selectedTrueFalse == q.correctTrueFalse;
        break;
      case LessonQuizType.shortAnswer:
        final input = _norm(_answerCtrl.text);
        final expected = q.expectedAnswers ?? const [];
        correct = expected.length == 1 && expected.first.isNotEmpty
            ? input.contains(expected.first)
            : expected.contains(input);
        break;
    }
    if (correct) _correctAnswers++;
    return correct;
  }

  String _norm(String s) => s.trim().toLowerCase();

  void _goNext() {
    if (_questionIndex + 1 >= _questions.length) return;
    setState(() {
      _questionIndex++;
      _resetCurrentAnswerState();
    });
  }

  void _goPrev() {
    if (_questionIndex <= 0) return;
    setState(() {
      _questionIndex--;
      _resetCurrentAnswerState();
    });
  }

  void _resetCurrentAnswerState() {
    _showAnswer = false;
    _checked = false;
    _isCorrect = null;
    _selectedChoice = null;
    _selectedTrueFalse = null;
    _answerCtrl.clear();
  }

  Future<void> _finishLesson() async {
    final timeSpent = DateTime.now().difference(_startTime).inMinutes.clamp(1, 60);
    final nodeId = LessonRepository.nodeIdFor(
      grade: widget.grade,
      subjectName: widget.subject,
      unitNumber: 1,
      topicIndex: 0,
    );

    final result = await _progressService.onLessonCompleted(
      nodeId: nodeId,
      timeSpentMinutes: timeSpent,
    );

    if (!mounted) return;

    if (result.xpEarned > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.leveledUp
                ? '🎉 Level ${result.newLevel} боллоо!  +${result.xpEarned} XP ($_correctAnswers/${_questions.length})'
                : '+${result.xpEarned} XP  +${result.coinsEarned} 🪙 ($_correctAnswers/${_questions.length})',
          ),
          backgroundColor: Colors.green.shade700,
          duration: const Duration(seconds: 3),
        ),
      );
    }

    Navigator.of(context).pop();
  }
}

class _CardBlock extends StatelessWidget {
  const _CardBlock({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _QuizTypeBadge extends StatelessWidget {
  const _QuizTypeBadge({required this.type});

  final LessonQuizType type;

  @override
  Widget build(BuildContext context) {
    final label = switch (type) {
      LessonQuizType.multipleChoice => context.tr('Сонголтот', 'Multiple choice'),
      LessonQuizType.shortAnswer => context.tr('Богино хариу', 'Short answer'),
      LessonQuizType.trueFalse => context.tr('Үнэн/Худал', 'True/False'),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: context.appSurfaceVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _MultipleChoice extends StatelessWidget {
  const _MultipleChoice({
    required this.isEn,
    required this.question,
    required this.selectedIndex,
    required this.onChanged,
  });

  final bool isEn;
  final LessonQuestion question;
  final int? selectedIndex;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final choices = isEn ? (question.choicesEn ?? const []) : (question.choicesMn ?? const []);
    return Column(
      children: choices.asMap().entries.map((e) {
        final selected = selectedIndex == e.key;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onChanged(e.key),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: selected ? context.appSurfaceVariant : context.appCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: selected
                        ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)
                        : Theme.of(context).dividerColor.withValues(alpha: 0.7),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).dividerColor,
                          width: 2,
                        ),
                        color: selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                      ),
                      child: selected
                          ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(e.value)),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _TrueFalse extends StatelessWidget {
  const _TrueFalse({
    required this.isEn,
    required this.selected,
    required this.onChanged,
  });

  final bool isEn;
  final bool? selected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _tfButton(
            context,
            value: true,
            label: isEn ? 'True' : 'Үнэн',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _tfButton(
            context,
            value: false,
            label: isEn ? 'False' : 'Худал',
          ),
        ),
      ],
    );
  }

  Widget _tfButton(BuildContext context, {required bool value, required String label}) {
    final isSelected = selected == value;
    return OutlinedButton(
      onPressed: () => onChanged(value),
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? context.appSurfaceVariant : null,
      ),
      child: Text(label),
    );
  }
}

