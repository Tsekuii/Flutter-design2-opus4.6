import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/app_nav/app_nav_bloc.dart';
import '../widgets/app_bottom_nav.dart';
import 'ai_page.dart';
import 'create_quiz_page.dart';
import 'home_page.dart';
import 'lobby_page.dart';
import 'profile_page.dart';

/// Main shell with bottom nav. Shows one of Home, Create, AI, Lobby, Profile.
class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppNavBloc, AppNavState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.selectedIndex,
            children: const [
              HomePage(),
              CreateQuizPage(),
              AiPage(),
              LobbyPage(),
              ProfilePage(),
            ],
          ),
          bottomNavigationBar: AppBottomNav(),
        );
      },
    );
  }
}
