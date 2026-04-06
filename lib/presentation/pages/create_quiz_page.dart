import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question_model.dart';
import '../blocs/quiz_create/quiz_create_bloc.dart';
import 'add_question_sheet.dart';

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final _uuid = const Uuid();
  final _titleCtrl = TextEditingController();

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<QuizCreateBloc>().add(QuizCreateLoadMyQuizzes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<QuizCreateBloc, QuizCreateState>(
          listener: (context, state) {
            if (state.saveSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.check_circle_rounded, color: AppTheme.successGreen, size: 20),
                      const SizedBox(width: 8),
                      const Text('Quiz амжилттай хадгалагдлаа!'),
                    ],
                  ),
                ),
              );
              context.read<QuizCreateBloc>().add(QuizCreateLoadMyQuizzes());
            }
            if (state.saveError != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.saveError!)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // Header
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.edit_note_rounded, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quiz үүсгэх',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                'Өөрийн Quiz-ийг бүтээгээрэй',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Title field
                    Text(
                      'Quiz-ийн нэр',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _titleCtrl,
                      onChanged: (v) => context.read<QuizCreateBloc>().add(QuizCreateTitleChanged(v)),
                      decoration: const InputDecoration(
                        hintText: 'Математикийн Quiz #1',
                        prefixIcon: Icon(Icons.title_rounded, size: 20),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Upload options
                    Row(
                      children: [
                        _UploadCard(
                          icon: Icons.picture_as_pdf_rounded,
                          label: 'PDF',
                          gradient: AppTheme.warmGradient,
                          onTap: () {},
                        ),
                        const SizedBox(width: 12),
                        _UploadCard(
                          icon: Icons.image_rounded,
                          label: 'Зураг',
                          gradient: AppTheme.purpleGradient,
                          onTap: () {},
                        ),
                        const SizedBox(width: 12),
                        _UploadCard(
                          icon: Icons.text_snippet_rounded,
                          label: 'Текст',
                          gradient: AppTheme.primaryGradient,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Questions section
                    Row(
                      children: [
                        Text(
                          'Асуултууд',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (state.questions.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.accentCyan.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${state.questions.length}',
                              style: TextStyle(
                                color: AppTheme.accentCyan,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Add question button
                    GestureDetector(
                      onTap: () => _openAddQuestion(context),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: AppTheme.cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppTheme.accentCyan.withValues(alpha: 0.3),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppTheme.accentCyan.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Icons.add_rounded, color: AppTheme.accentCyan),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Асуулт нэмэх',
                              style: TextStyle(
                                color: AppTheme.accentCyan,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Question tiles
                    ...state.questions.asMap().entries.map((e) => _QuestionTile(
                          index: e.key + 1,
                          question: e.value,
                          onRemove: () =>
                              context.read<QuizCreateBloc>().add(QuizCreateQuestionRemoved(e.value.id)),
                        )),
                    const SizedBox(height: 24),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.preview_rounded, size: 20),
                              label: const Text('Урьдчилж харах'),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: AppTheme.successGradient,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.successGreen.withValues(alpha: 0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ElevatedButton.icon(
                                onPressed: state.saving
                                    ? null
                                    : () => context.read<QuizCreateBloc>().add(QuizCreateSaveRequested()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                                icon: state.saving
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                      )
                                    : const Icon(Icons.save_rounded, size: 20, color: Colors.white),
                                label: const Text(
                                  'Хадгалах',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openAddQuestion(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AddQuestionSheet(
        onAdd: (q) {
          context.read<QuizCreateBloc>().add(QuizCreateQuestionAdded(q));
          Navigator.pop(ctx);
        },
        nextId: _uuid.v4(),
      ),
    );
  }
}

class _UploadCard extends StatelessWidget {
  const _UploadCard({
    required this.icon,
    required this.label,
    required this.gradient,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final LinearGradient gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF1E2A3D)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 22, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionTile extends StatelessWidget {
  const _QuestionTile({required this.index, required this.question, required this.onRemove});

  final int index;
  final QuestionModel question;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final typeLabel = question.type == QuestionType.multipleChoice
        ? 'Олон сонголт'
        : question.type == QuestionType.trueFalse
            ? 'Үнэн/Худал'
            : 'Текст';

    final typeColor = question.type == QuestionType.multipleChoice
        ? AppTheme.accentCyan
        : question.type == QuestionType.trueFalse
            ? AppTheme.accentPurple
            : AppTheme.warningOrange;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF1E2A3D)),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppTheme.accentCyan.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '#$index',
                  style: TextStyle(
                    color: AppTheme.accentCyan,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                typeLabel,
                style: TextStyle(
                  fontSize: 11,
                  color: typeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                question.text.isEmpty ? '(Асуулт оруулах)' : question.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
              ),
            ),
            GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.errorRed.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.close_rounded, color: AppTheme.errorRed, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
