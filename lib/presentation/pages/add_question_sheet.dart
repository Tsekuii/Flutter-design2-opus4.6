import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question_model.dart';

class AddQuestionSheet extends StatefulWidget {
  const AddQuestionSheet({
    super.key,
    required this.onAdd,
    required this.nextId,
  });

  final void Function(QuestionModel question) onAdd;
  final String nextId;

  @override
  State<AddQuestionSheet> createState() => _AddQuestionSheetState();
}

class _AddQuestionSheetState extends State<AddQuestionSheet> {
  QuestionType _type = QuestionType.multipleChoice;
  final _textCtrl = TextEditingController();
  final _optionACtrl = TextEditingController();
  final _optionBCtrl = TextEditingController();
  final _optionCCtrl = TextEditingController();
  final _optionDCtrl = TextEditingController();
  int? _correctIndex;
  final _correctTextCtrl = TextEditingController();
  final _explanationCtrl = TextEditingController();

  @override
  void dispose() {
    _textCtrl.dispose();
    _optionACtrl.dispose();
    _optionBCtrl.dispose();
    _optionCCtrl.dispose();
    _optionDCtrl.dispose();
    _correctTextCtrl.dispose();
    _explanationCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _textCtrl.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Асуулт оруулна уу')));
      return;
    }
    if (_type == QuestionType.multipleChoice) {
      final options = [
        _optionACtrl.text.trim(),
        _optionBCtrl.text.trim(),
        _optionCCtrl.text.trim(),
        _optionDCtrl.text.trim(),
      ].where((e) => e.isNotEmpty).toList();
      if (options.length < 2) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Дор хаяж 2 сонголт оруулна уу')));
        return;
      }
      widget.onAdd(QuestionModel(
        id: widget.nextId,
        type: QuestionType.multipleChoice,
        text: text,
        options: options,
        correctOptionIndex: _correctIndex != null && _correctIndex! < options.length ? _correctIndex : 0,
        explanation: _explanationCtrl.text.trim().isEmpty ? null : _explanationCtrl.text.trim(),
      ));
    } else if (_type == QuestionType.trueFalse) {
      widget.onAdd(QuestionModel(
        id: widget.nextId,
        type: QuestionType.trueFalse,
        text: text,
        options: ['Үнэн', 'Худал'],
        correctOptionIndex: _correctIndex ?? 0,
        explanation: _explanationCtrl.text.trim().isEmpty ? null : _explanationCtrl.text.trim(),
      ));
    } else {
      widget.onAdd(QuestionModel(
        id: widget.nextId,
        type: QuestionType.textAnswer,
        text: text,
        correctTextAnswer: _correctTextCtrl.text.trim().isEmpty ? null : _correctTextCtrl.text.trim(),
        explanation: _explanationCtrl.text.trim().isEmpty ? null : _explanationCtrl.text.trim(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.bgDark,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: const Border(
          top: BorderSide(color: Color(0xFF1E2A3D)),
          left: BorderSide(color: Color(0xFF1E2A3D)),
          right: BorderSide(color: Color(0xFF1E2A3D)),
        ),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A3448),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Шинэ асуулт нэмэх', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),

            // Question type
            Text(
              'Асуултын төрөл',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _TypeChip(
                  label: 'Олон сонголт',
                  selected: _type == QuestionType.multipleChoice,
                  color: AppTheme.accentCyan,
                  onTap: () => setState(() => _type = QuestionType.multipleChoice),
                ),
                const SizedBox(width: 8),
                _TypeChip(
                  label: 'Үнэн/Худал',
                  selected: _type == QuestionType.trueFalse,
                  color: AppTheme.accentPurple,
                  onTap: () => setState(() => _type = QuestionType.trueFalse),
                ),
                const SizedBox(width: 8),
                _TypeChip(
                  label: 'Текст',
                  selected: _type == QuestionType.textAnswer,
                  color: AppTheme.warningOrange,
                  onTap: () => setState(() => _type = QuestionType.textAnswer),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Question text
            Text(
              'Асуулт',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _textCtrl,
              maxLines: 3,
              decoration: const InputDecoration(hintText: 'Асуултаа бичнэ үү...'),
            ),

            if (_type == QuestionType.multipleChoice) ...[
              const SizedBox(height: 20),
              Text(
                'Сонголтууд',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              _OptionField(label: 'А', controller: _optionACtrl, isCorrect: _correctIndex == 0, onTap: () => setState(() => _correctIndex = 0)),
              _OptionField(label: 'В', controller: _optionBCtrl, isCorrect: _correctIndex == 1, onTap: () => setState(() => _correctIndex = 1)),
              _OptionField(label: 'С', controller: _optionCCtrl, isCorrect: _correctIndex == 2, onTap: () => setState(() => _correctIndex = 2)),
              _OptionField(label: 'D', controller: _optionDCtrl, isCorrect: _correctIndex == 3, onTap: () => setState(() => _correctIndex = 3)),
            ],

            if (_type == QuestionType.trueFalse) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  _TypeChip(
                    label: 'Үнэн',
                    selected: _correctIndex == 0,
                    color: AppTheme.successGreen,
                    onTap: () => setState(() => _correctIndex = 0),
                  ),
                  const SizedBox(width: 8),
                  _TypeChip(
                    label: 'Худал',
                    selected: _correctIndex == 1,
                    color: AppTheme.errorRed,
                    onTap: () => setState(() => _correctIndex = 1),
                  ),
                ],
              ),
            ],

            if (_type == QuestionType.textAnswer) ...[
              const SizedBox(height: 14),
              TextField(
                controller: _correctTextCtrl,
                decoration: const InputDecoration(
                  labelText: 'Зөв хариулт',
                  prefixIcon: Icon(Icons.check_circle_outline_rounded, size: 20),
                ),
              ),
            ],

            const SizedBox(height: 14),
            TextField(
              controller: _explanationCtrl,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Тайлбар (заавал биш)',
                prefixIcon: Icon(Icons.lightbulb_outline_rounded, size: 20),
              ),
            ),
            const SizedBox(height: 24),

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
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    'Асуулт нэмэх',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.15) : AppTheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? color.withValues(alpha: 0.5) : const Color(0xFF1E2A3D),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? color : AppTheme.textSecondary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _OptionField extends StatelessWidget {
  const _OptionField({
    required this.label,
    required this.controller,
    required this.isCorrect,
    required this.onTap,
  });

  final String label;
  final TextEditingController controller;
  final bool isCorrect;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: isCorrect ? AppTheme.successGradient : null,
                color: isCorrect ? null : AppTheme.surfaceVariant,
                borderRadius: BorderRadius.circular(10),
                border: isCorrect ? null : Border.all(color: const Color(0xFF1E2A3D)),
              ),
              child: Center(
                child: isCorrect
                    ? const Icon(Icons.check_rounded, color: Colors.white, size: 18)
                    : Text(
                        label,
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Сонголт $label',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
