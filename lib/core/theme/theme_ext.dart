import 'package:flutter/material.dart';

extension ThemeExt on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get appCard {
    final theme = Theme.of(this);
    return theme.cardTheme.color ?? theme.colorScheme.surface;
  }

  Color get appSurfaceVariant {
    final scheme = Theme.of(this).colorScheme;
    // Material 3 container color, falls back to surface.
    return scheme.surfaceContainerHighest;
  }

  Color get appTextSecondary {
    final theme = Theme.of(this);
    return theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurface.withValues(alpha: 0.7);
  }

  Color get appTextMuted {
    final theme = Theme.of(this);
    return theme.textTheme.labelSmall?.color ?? theme.colorScheme.onSurface.withValues(alpha: 0.55);
  }
}

