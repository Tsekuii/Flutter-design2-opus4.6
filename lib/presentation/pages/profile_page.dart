import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/profile/profile_bloc.dart';
import '../blocs/settings/settings_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final user = state.user ?? context.read<AuthBloc>().state.user;
            if (user == null) {
              return const Center(child: Text('Нэвтрэнэ үү'));
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  // Profile header card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF0C2D48), Color(0xFF1A0B2E)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppTheme.accentPurple.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                gradient: AppTheme.warmGradient,
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.warningOrange.withValues(alpha: 0.3),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  user.displayName.isNotEmpty
                                      ? user.displayName[0].toUpperCase()
                                      : '?',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.displayName,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${user.classGrade}-р анги',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Level progress
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ShaderMask(
                                        shaderCallback: (bounds) =>
                                            AppTheme.warmGradient.createShader(bounds),
                                        child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 20),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Түвшин ${user.level}',
                                        style: const TextStyle(fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${user.xp % 1000} / 1000 XP',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: AppTheme.surfaceVariant,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: (user.xp % 1000) / 1000,
                                      child: Container(
                                        height: 8,
                                        decoration: BoxDecoration(
                                          gradient: AppTheme.warmGradient,
                                          borderRadius: BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppTheme.warningOrange.withValues(alpha: 0.4),
                                              blurRadius: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Stats grid
                  Row(
                    children: [
                      _StatCard(
                        icon: Icons.local_fire_department_rounded,
                        value: '${user.streakDays}',
                        label: 'Дэс',
                        gradient: AppTheme.warmGradient,
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        icon: Icons.emoji_events_rounded,
                        value: '${user.coins}',
                        label: 'Зоос',
                        gradient: AppTheme.primaryGradient,
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        icon: Icons.bolt_rounded,
                        value: '${user.xp}',
                        label: 'XP',
                        gradient: AppTheme.purpleGradient,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tab switch
                  Row(
                    children: [
                      _ProfileTab(
                        label: 'Явц',
                        icon: Icons.trending_up_rounded,
                        selected: state.activeTab == 'progress',
                        onTap: () => context.read<ProfileBloc>().add(const ProfileTabChanged('progress')),
                      ),
                      const SizedBox(width: 12),
                      _ProfileTab(
                        label: 'Тохиргоо',
                        icon: Icons.settings_rounded,
                        selected: state.activeTab == 'settings',
                        onTap: () => context.read<ProfileBloc>().add(const ProfileTabChanged('settings')),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  if (state.activeTab == 'progress') ...[
                    // Metrics
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.5,
                      children: [
                        _MetricCard(
                          icon: Icons.menu_book_rounded,
                          value: '${user.completedLessonsCount}',
                          label: 'Дууссан хичээл',
                          color: AppTheme.accentCyan,
                        ),
                        _MetricCard(
                          icon: Icons.access_time_rounded,
                          value: '${user.totalTimeMinutes}м',
                          label: 'Нийт цаг',
                          color: AppTheme.accentPurple,
                        ),
                        _MetricCard(
                          icon: Icons.gps_fixed_rounded,
                          value: '${user.averageScorePercent}%',
                          label: 'Дундаж оноо',
                          color: AppTheme.successGreen,
                        ),
                        _MetricCard(
                          icon: Icons.emoji_events_rounded,
                          value: '${user.awardsCount}',
                          label: 'Авсан шагнал',
                          color: AppTheme.warningYellow,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Achievements
                    Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (b) => AppTheme.warmGradient.createShader(b),
                          child: const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 22),
                        ),
                        const SizedBox(width: 8),
                        Text('Амжилтууд', style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (state.loading)
                      const Center(child: CircularProgressIndicator())
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: state.achievements.length,
                        itemBuilder: (context, i) {
                          final a = state.achievements[i];
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.cardColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: a.isUnlocked
                                    ? AppTheme.warningYellow.withValues(alpha: 0.3)
                                    : const Color(0xFF1E2A3D),
                              ),
                              boxShadow: a.isUnlocked
                                  ? [
                                      BoxShadow(
                                        color: AppTheme.warningYellow.withValues(alpha: 0.1),
                                        blurRadius: 12,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    gradient: a.isUnlocked ? AppTheme.warmGradient : null,
                                    color: a.isUnlocked ? null : AppTheme.surfaceVariant,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Icon(
                                    _achievementIcon(a.iconName),
                                    size: 24,
                                    color: a.isUnlocked ? Colors.white : AppTheme.textMuted,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  a.titleMn,
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: a.isUnlocked ? null : AppTheme.textMuted,
                                      ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ] else
                    _SettingsSection(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  static IconData _achievementIcon(String name) {
    switch (name) {
      case 'target':
        return Icons.gps_fixed_rounded;
      case 'flame':
        return Icons.local_fire_department_rounded;
      case 'math':
        return Icons.calculate_rounded;
      case 'graduation':
        return Icons.school_rounded;
      case 'crown':
        return Icons.emoji_events_rounded;
      default:
        return Icons.star_rounded;
    }
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
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
              shaderCallback: (b) => gradient.createShader(b),
              child: Icon(icon, size: 26, color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 2),
            Text(label, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: selected ? AppTheme.primaryGradient : null,
            color: selected ? null : AppTheme.surfaceVariant,
            borderRadius: BorderRadius.circular(14),
            border: selected ? null : Border.all(color: const Color(0xFF1E2A3D)),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: AppTheme.accentCyan.withValues(alpha: 0.25),
                      blurRadius: 12,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: selected ? Colors.white : AppTheme.textSecondary),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : AppTheme.textSecondary,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E2A3D)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsCubit>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Language
        _SettingsGroup(
          title: 'Хэл',
          icon: Icons.language_rounded,
          child: Row(
            children: [
              _SettingsChip(
                label: '🇲🇳 Монгол',
                selected: settings.localeCode == 'mn',
                onTap: () => context.read<SettingsCubit>().setLocale('mn'),
              ),
              const SizedBox(width: 10),
              _SettingsChip(
                label: '🇬🇧 English',
                selected: settings.localeCode == 'en',
                onTap: () => context.read<SettingsCubit>().setLocale('en'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Theme
        _SettingsGroup(
          title: 'Загвар',
          icon: Icons.palette_outlined,
          child: Row(
            children: [
              _SettingsChip(
                label: '🌙 Харанхуй',
                selected: settings.themeMode == ThemeMode.dark,
                onTap: () => context.read<SettingsCubit>().setThemeMode(ThemeMode.dark),
              ),
              const SizedBox(width: 10),
              _SettingsChip(
                label: '☀️ Гэрэл',
                selected: settings.themeMode == ThemeMode.light,
                onTap: () => context.read<SettingsCubit>().setThemeMode(ThemeMode.light),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Logout button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () => context.read<AuthBloc>().add(AuthLogoutRequested()),
            icon: const Icon(Icons.logout_rounded, size: 20),
            label: const Text('Гарах'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.errorRed,
              side: BorderSide(color: AppTheme.errorRed.withValues(alpha: 0.3)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E2A3D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: AppTheme.textSecondary),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _SettingsChip extends StatelessWidget {
  const _SettingsChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          gradient: selected ? AppTheme.primaryGradient : null,
          color: selected ? null : AppTheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: selected ? null : Border.all(color: const Color(0xFF1E2A3D)),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppTheme.accentCyan.withValues(alpha: 0.2),
                    blurRadius: 8,
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppTheme.textSecondary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
