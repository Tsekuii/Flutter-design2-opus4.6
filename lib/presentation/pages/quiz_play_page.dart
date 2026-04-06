import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question_model.dart';

class QuizPlayPage extends StatefulWidget {
  const QuizPlayPage({
    super.key,
    required this.title,
    this.questionCount = 5,
    this.questions,
  });

  final String title;
  final int questionCount;
  final List<QuestionModel>? questions;

  @override
  State<QuizPlayPage> createState() => _QuizPlayPageState();
}

class _QuizPlayPageState extends State<QuizPlayPage> {
  int _currentIndex = 0;
  int _correctCount = 0;
  int? _selectedIndex;
  bool _showFeedback = false;
  bool _isCorrect = false;

  late List<QuestionModel> _questions;

  @override
  void initState() {
    super.initState();
    _questions = widget.questions ?? _mockQuestions(widget.questionCount);
  }

  List<QuestionModel> _mockQuestions(int n) {
    return List.generate(n, (i) {
      return QuestionModel(
        id: 'q$i',
        type: QuestionType.multipleChoice,
        text: 'Хэрэв у = 2х функц өгөгдсөн бол х = ${i + 5} үед у-ийн утга хэд вэ?',
        options: ['${(i + 5) * 2 - 2}', '${(i + 5) * 2}', '${(i + 5) * 2 + 2}', '${(i + 5) + 2}'],
        correctOptionIndex: 1,
        explanation: 'у = 2х функцэд х = ${i + 5} орлуулбал у = 2(${i + 5}) = ${(i + 5) * 2}',
      );
    });
  }

  void _onAnswerSelected(int index) {
    if (_showFeedback) return;
    final q = _questions[_currentIndex];
    final correct = q.correctOptionIndex == index;
    setState(() {
      _selectedIndex = index;
      _showFeedback = true;
      _isCorrect = correct;
      if (correct) _correctCount++;
    });
  }

  void _next() {
    if (_currentIndex + 1 >= _questions.length) {
      _finish();
      return;
    }
    setState(() {
      _currentIndex++;
      _selectedIndex = null;
      _showFeedback = false;
    });
  }

  void _finish() {
    final score = (_correctCount / _questions.length * 100).round();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: AppTheme.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  gradient: score >= 70 ? AppTheme.successGradient : AppTheme.warmGradient,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: (score >= 70 ? AppTheme.successGreen : AppTheme.warningOrange)
                          .withValues(alpha: 0.3),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Icon(
                  score >= 70 ? Icons.emoji_events_rounded : Icons.trending_up_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                score >= 70 ? 'Гайхалтай!' : 'Дахин оролдоорой!',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              ShaderMask(
                shaderCallback: (b) => (score >= 70 ? AppTheme.successGradient : AppTheme.warmGradient)
                    .createShader(b),
                child: Text(
                  '$score%',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${_questions.length}-аас $_correctCount зөв',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Хаах'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Гарах', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.close_rounded, size: 20),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${_currentIndex + 1} / ${_questions.length}',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: [
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    AnimatedFractionallySizedBox(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      widthFactor: progress,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.accentCyan.withValues(alpha: 0.4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Question body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF0C2D48), Color(0xFF121829)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppTheme.accentCyan.withValues(alpha: 0.12)),
                      ),
                      child: Text(
                        q.text,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: 17,
                              height: 1.5,
                            ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Options
                    Expanded(
                      child: ListView.builder(
                        itemCount: q.options.length,
                        itemBuilder: (context, i) {
                          final isCorrectOption = i == q.correctOptionIndex;
                          final isSelectedWrong = _showFeedback && i == _selectedIndex && !_isCorrect;

                          Color? borderColor;
                          Color? bgColor;
                          if (_showFeedback) {
                            if (isCorrectOption) {
                              borderColor = AppTheme.successGreen.withValues(alpha: 0.6);
                              bgColor = AppTheme.successGreen.withValues(alpha: 0.1);
                            } else if (isSelectedWrong) {
                              borderColor = AppTheme.errorRed.withValues(alpha: 0.6);
                              bgColor = AppTheme.errorRed.withValues(alpha: 0.1);
                            }
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: GestureDetector(
                              onTap: () => _onAnswerSelected(i),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: bgColor ?? AppTheme.cardColor,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: borderColor ?? const Color(0xFF1E2A3D),
                                    width: borderColor != null ? 1.5 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        gradient: (_showFeedback && isCorrectOption)
                                            ? AppTheme.successGradient
                                            : isSelectedWrong
                                                ? null
                                                : null,
                                        color: (_showFeedback && isCorrectOption)
                                            ? null
                                            : isSelectedWrong
                                                ? AppTheme.errorRed.withValues(alpha: 0.15)
                                                : AppTheme.surfaceVariant,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: _showFeedback && isCorrectOption
                                            ? const Icon(Icons.check_rounded, color: Colors.white, size: 18)
                                            : isSelectedWrong
                                                ? Icon(Icons.close_rounded, color: AppTheme.errorRed, size: 18)
                                                : Text(
                                                    String.fromCharCode(0x41 + i),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      color: AppTheme.accentCyan,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Text(
                                        q.options[i],
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Feedback and next
                    if (_showFeedback && q.explanation != null) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _isCorrect
                                ? [
                                    AppTheme.successGreen.withValues(alpha: 0.12),
                                    AppTheme.successGreen.withValues(alpha: 0.06),
                                  ]
                                : [
                                    AppTheme.errorRed.withValues(alpha: 0.12),
                                    AppTheme.errorRed.withValues(alpha: 0.06),
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: (_isCorrect ? AppTheme.successGreen : AppTheme.errorRed)
                                .withValues(alpha: 0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  _isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                                  color: _isCorrect ? AppTheme.successGreen : AppTheme.errorRed,
                                  size: 22,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _isCorrect ? 'Зөв!' : 'Буруу',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: _isCorrect ? AppTheme.successGreen : AppTheme.errorRed,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              q.explanation!,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.accentCyan.withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _next,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              _currentIndex + 1 >= _questions.length ? 'Дуусгах' : 'Дараагийн',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
