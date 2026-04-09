import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/blocs/settings/settings_cubit.dart';

extension TrExt on BuildContext {
  bool get isEn => watch<SettingsCubit>().state.localeCode == 'en';

  String tr(String mn, String en) => isEn ? en : mn;
}

