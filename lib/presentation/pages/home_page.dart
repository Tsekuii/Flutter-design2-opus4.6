import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../data/models/subject_model.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/lesson/lesson_bloc.dart';
import 'auth_page.dart';
import 'lesson_unit_page.dart';

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
          final subjects = state.subjects;
          final loading = state.loading;
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
                      label: 'Дэс',
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
                      label: 'Түвшин',
                      gradient: AppTheme.purpleGradient,
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Class selector
                Text(
                  'Анги сонгох',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
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
                const SizedBox(height: 28),

                // Subjects header
                Row(
                  children: [
                    Text(
                      'Хичээлүүд',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    if (subjects.isNotEmpty)
                      Text(
                        '${subjects.length} хичээл',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                if (loading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (subjects.isEmpty)
                  _EmptyState()
                else
                  ...subjects.asMap().entries.map((entry) => _SubjectCard(
                        subject: entry.value,
                        index: entry.key,
                        onTap: () {
                          context.read<LessonBloc>().add(LessonSubjectSelected(entry.value));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<LessonBloc>(),
                                child: const LessonUnitPage(),
                              ),
                            ),
                          );
                        },
                      )),
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
                      'Сайн байна уу',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondary,
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
                    'Түвшин $level',
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

const _subjectIcons = [
  Icons.calculate_rounded,
  Icons.science_rounded,
  Icons.language_rounded,
  Icons.public_rounded,
  Icons.music_note_rounded,
  Icons.brush_rounded,
  Icons.computer_rounded,
  Icons.biotech_rounded,
];

const _subjectGradients = [
  AppTheme.primaryGradient,
  AppTheme.purpleGradient,
  AppTheme.warmGradient,
  AppTheme.successGradient,
  AppTheme.primaryGradient,
  AppTheme.purpleGradient,
  AppTheme.warmGradient,
  AppTheme.successGradient,
];

class _SubjectCard extends StatelessWidget {
  const _SubjectCard({
    required this.subject,
    required this.index,
    required this.onTap,
  });

  final SubjectModel subject;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final gradient = _subjectGradients[index % _subjectGradients.length];
    final icon = _subjectIcons[index % _subjectIcons.length];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF1E2A3D)),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: gradient.colors.first.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 26),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject.nameMn,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${subject.classGrade}-р анги',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                ),
              ],
            ),
          ),
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
              color: AppTheme.textMuted,
            ),
            const SizedBox(height: 16),
            Text(
              'Энэ ангид хичээл байхгүй байна',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textMuted,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
