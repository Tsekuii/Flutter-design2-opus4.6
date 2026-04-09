import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../core/data/grade_lessons_data.dart';
import '../../core/i18n/tr.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/theme_ext.dart';
import '../../core/utils/responsive.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/lesson/lesson_bloc.dart';
import 'auth_page.dart';
import 'lesson_interactive_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _lessonLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, authState) {
            if (authState.status == AuthStatus.unauthenticated) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const AuthPage()),
              );
            }
          },
          builder: (context, authState) {
            if (authState.status != AuthStatus.authenticated && authState.status != AuthStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (authState.status == AuthStatus.initial) {
              context.read<AuthBloc>().add(AuthCheckRequested());
              return const Center(child: CircularProgressIndicator());
            }
            final user = authState.user;
            if (user != null && !_lessonLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!_lessonLoaded && context.mounted) {
                  _lessonLoaded = true;
                  context.read<LessonBloc>().add(LessonClassSelected(user.classGrade));
                }
              });
            }
            return _HomeBody(
              userName: user?.displayName ?? 'Хэрэглэгч',
              classGrade: user?.classGrade ?? 10,
              streakDays: user?.streakDays ?? 0,
              xp: user?.xp ?? 0,
              level: user?.level ?? 1,
            );
          },
        ),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({
    required this.userName,
    required this.classGrade,
    required this.streakDays,
    required this.xp,
    required this.level,
  });

  final String userName;
  final int classGrade;
  final int streakDays;
  final int xp;
  final int level;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Responsive.screenPadding(context),
      child: BlocBuilder<LessonBloc, LessonState>(
        builder: (context, state) {
          final selectedClass = state.selectedClass;
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                // Hero welcome section
                _WelcomeHero(
                  userName: userName,
                  streakDays: streakDays,
                  xp: xp,
                  level: level,
                ),
                const SizedBox(height: 28),

                // Quick stats row
                Row(
                  children: [
                    _QuickStat(
                      icon: Icons.local_fire_department_rounded,
                      value: '$streakDays',
                  label: context.tr('Дэс', 'Streak'),
                      gradient: AppTheme.warmGradient,
                    ),
                    const SizedBox(width: 12),
                    _QuickStat(
                      icon: Icons.bolt_rounded,
                      value: '$xp',
                      label: 'XP',
                      gradient: AppTheme.primaryGradient,
                    ),
                    const SizedBox(width: 12),
                    _QuickStat(
                      icon: Icons.emoji_events_rounded,
                      value: '$level',
                  label: context.tr('Түвшин', 'Level'),
                      gradient: AppTheme.purpleGradient,
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Clickable "Анги сонгох" bar -> "Хичээлүүд" topic -> lessons list
                ExpansionTile(
                  key: const PageStorageKey('angi_songoh'),
                  maintainState: true,
                  title: Text(
                    context.tr('Анги сонгох', 'Select grade'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  children: [
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 42,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: AppConstants.maxClass - AppConstants.minClass + 1,
                        itemBuilder: (context, i) {
                          final grade = AppConstants.minClass + i;
                          final selected = grade == selectedClass;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () => context.read<LessonBloc>().add(LessonClassSelected(grade)),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  gradient: selected ? AppTheme.primaryGradient : null,
                                  color: selected ? null : AppTheme.surfaceVariant,
                                  borderRadius: BorderRadius.circular(12),
                                  border: selected
                                      ? null
                                      : Border.all(color: const Color(0xFF1E2A3D)),
                                  boxShadow: selected
                                      ? [
                                          BoxShadow(
                                            color: AppTheme.accentCyan.withValues(alpha: 0.25),
                                            blurRadius: 12,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    '$grade',
                                    style: TextStyle(
                                      color: selected ? Colors.white : AppTheme.textSecondary,
                                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    ExpansionTile(
                      key: PageStorageKey('hiceeluud_$selectedClass'),
                      maintainState: true,
                      title: Text(
                        context.tr('Хичээлүүд', 'Subjects'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 12, 14),
                          child: _GradeLessonsList(grade: selectedClass),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _WelcomeHero extends StatelessWidget {
  const _WelcomeHero({
    required this.userName,
    required this.streakDays,
    required this.xp,
    required this.level,
  });

  final String userName;
  final int streakDays;
  final int xp;
  final int level;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0C2D48),
            Color(0xFF0F1B3D),
            Color(0xFF1A0B2E),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.accentCyan.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accentCyan.withValues(alpha: 0.08),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      context.tr('Сайн байна уу', 'Hello'),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: context.appTextSecondary,
                          ),
                    ),
                    const SizedBox(width: 4),
                    const Text('👋', style: TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  userName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    context.tr('Түвшин $level', 'Level $level'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accentCyan.withValues(alpha: 0.3),
                  blurRadius: 16,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: const Icon(Icons.school_rounded, size: 36, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _QuickStat extends StatelessWidget {
  const _QuickStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.gradient,
  });

  final IconData icon;
  final String value;
  final String label;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF1E2A3D)),
        ),
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => gradient.createShader(bounds),
              child: Icon(icon, size: 24, color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(
              Icons.menu_book_outlined,
              size: 64,
              color: context.appTextMuted,
            ),
            const SizedBox(height: 16),
            Text(
              context.tr('Энэ ангид хичээл байхгүй байна', 'No lessons for this grade yet'),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: context.appTextMuted,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _GradeLessonsList extends StatelessWidget {
  const _GradeLessonsList({required this.grade});

  final int grade;

  static final _chipColors = <Color>[
    AppTheme.accentCyan,
    AppTheme.accentBlue,
    AppTheme.accentPurple,
    AppTheme.accentPink,
  ];

  @override
  Widget build(BuildContext context) {
    final lessons = GradeLessonsData.getLessonsForGrade(grade);
    if (lessons.isEmpty) return _EmptyState();

    final groups = lessons.entries.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groups.asMap().entries.map((entry) {
        final groupIndex = entry.key;
        final subject = entry.value.key;
        final topics = entry.value.value;
        final baseColor = _chipColors[groupIndex % _chipColors.length];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: topics.map((t) {
                  return _LessonChip(
                    label: t,
                    color: baseColor,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => LessonInteractivePage(
                            grade: grade,
                            subject: subject,
                            topic: t,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _LessonChip extends StatelessWidget {
  const _LessonChip({required this.label, required this.color, required this.onTap});

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withValues(alpha: 0.22)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
