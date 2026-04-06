import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../blocs/app_nav/app_nav_bloc.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key});

  static const _labels = ['Нүүр', 'Үүсгэх', 'AI', 'Лобби', 'Профайл'];
  static const _icons = [
    Icons.home_rounded,
    Icons.add_circle_rounded,
    Icons.auto_awesome_rounded,
    Icons.groups_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppNavBloc, AppNavState>(
      buildWhen: (a, b) => a.selectedIndex != b.selectedIndex,
      builder: (context, state) {
        final index = state.selectedIndex;
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.cardColor.withValues(alpha: 0.92),
            border: const Border(
              top: BorderSide(color: Color(0xFF1E2A3D), width: 0.5),
            ),
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(5, (i) {
                      final selected = index == i;
                      final isCenterAction = i == AppConstants.navAi;
                      return _NavItem(
                        icon: _icons[i],
                        label: _labels[i],
                        isSelected: selected,
                        isCenterAction: isCenterAction,
                        onTap: () => context.read<AppNavBloc>().add(AppNavTabChanged(i)),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.isCenterAction = false,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isCenterAction;

  @override
  Widget build(BuildContext context) {
    final selectedColor = isCenterAction ? AppTheme.accentPurple : AppTheme.accentCyan;
    final color = isSelected ? selectedColor : AppTheme.textMuted;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? selectedColor.withValues(alpha: 0.12) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: isCenterAction && isSelected ? 28 : 24,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
