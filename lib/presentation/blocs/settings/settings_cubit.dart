import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());

  void setThemeMode(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
  }

  void setLocale(String localeCode) {
    emit(state.copyWith(localeCode: localeCode));
  }
}

class SettingsState {
  const SettingsState({
    this.themeMode = ThemeMode.dark,
    this.localeCode = 'mn',
  });

  factory SettingsState.initial() => const SettingsState();

  final ThemeMode themeMode;
  final String localeCode;

  SettingsState copyWith({ThemeMode? themeMode, String? localeCode}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      localeCode: localeCode ?? this.localeCode,
    );
  }
}
