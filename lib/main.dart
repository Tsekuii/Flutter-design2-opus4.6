import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import 'core/theme/app_theme.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/lesson_repository.dart';
import 'data/repositories/lobby_repository.dart';
import 'data/repositories/profile_repository.dart';
import 'data/repositories/quiz_repository.dart';
import 'presentation/blocs/app_nav/app_nav_bloc.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/lesson/lesson_bloc.dart';
import 'presentation/blocs/lobby/lobby_bloc.dart';
import 'presentation/blocs/profile/profile_bloc.dart';
import 'presentation/blocs/quiz_create/quiz_create_bloc.dart';
import 'presentation/blocs/settings/settings_cubit.dart';
import 'presentation/pages/auth_page.dart';
import 'presentation/pages/main_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const supabaseUrl = String.fromEnvironment('SUPABASE_URL', defaultValue: '');
  const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');
  if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0A0E1A),
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    runApp(const _SupabaseConfigMissingApp());
    return;
  }

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0A0E1A),
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const OlimpiadApp());
}

/// Shown when the app is run without compile-time Supabase credentials (e.g. Chrome Run with no `--dart-define`).
class _SupabaseConfigMissingApp extends StatelessWidget {
  const _SupabaseConfigMissingApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SelectableText.rich(
              TextSpan(
                style: const TextStyle(fontSize: 15, height: 1.4),
                children: [
                  const TextSpan(
                    text: 'Supabase is not configured.\n\n'
                        'This app needs SUPABASE_URL and SUPABASE_ANON_KEY at compile time.\n\n'
                        'Terminal (PowerShell):\n',
                  ),
                  TextSpan(
                    text: 'flutter run -d chrome `\n'
                        '  --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co `\n'
                        '  --dart-define=SUPABASE_ANON_KEY=YOUR_ANON_KEY\n\n',
                    style: TextStyle(color: Colors.cyan.shade200),
                  ),
                  const TextSpan(
                    text: 'Or add the same --dart-define lines to .vscode/launch.json (see project template).\n\n'
                        'After changing defines, stop the app and run a full restart (not only hot reload).',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OlimpiadApp extends StatelessWidget {
  const OlimpiadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => LessonRepository()),
        RepositoryProvider(create: (_) => QuizRepository()),
        RepositoryProvider(create: (_) => LobbyRepository()),
        RepositoryProvider(create: (c) => ProfileRepository(c.read<AuthRepository>())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (c) => AuthBloc(c.read<AuthRepository>())..add(AuthCheckRequested())),
          BlocProvider(create: (_) => AppNavBloc()),
          BlocProvider(create: (c) => LessonBloc(c.read<LessonRepository>())),
          BlocProvider(create: (c) => QuizCreateBloc(c.read<QuizRepository>())),
          BlocProvider(create: (c) => LobbyBloc(c.read<LobbyRepository>())),
          BlocProvider(create: (c) => ProfileBloc(c.read<ProfileRepository>())),
          BlocProvider(create: (_) => SettingsCubit()),
        ],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (a, b) => a.themeMode != b.themeMode,
          builder: (context, settings) {
            final theme = settings.themeMode == ThemeMode.dark ? AppTheme.dark() : AppTheme.light();
            return MaterialApp(
              title: 'Олимпиад',
              debugShowCheckedModeBanner: false,
              theme: theme,
              home: BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (a, b) => a.status != b.status,
                builder: (context, authState) {
                  if (authState.status == AuthStatus.initial || authState.status == AuthStatus.loading) {
                    return const _SplashScreen();
                  }
                  if (authState.status == AuthStatus.authenticated) {
                    return const MainShell();
                  }
                  return const AuthPage();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A0E1A),
              Color(0xFF0F1B3D),
              Color(0xFF1A0B2E),
              Color(0xFF0A0E1A),
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.accentCyan.withValues(alpha: 0.35),
                      blurRadius: 32,
                      spreadRadius: -4,
                    ),
                  ],
                ),
                child: const Icon(Icons.school_rounded, size: 46, color: Colors.white),
              ),
              const SizedBox(height: 24),
              ShaderMask(
                shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
                child: Text(
                  'Олимпиад',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppTheme.accentCyan,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
