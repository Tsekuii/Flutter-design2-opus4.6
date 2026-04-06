import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/lobby_model.dart' show LobbyModel, LobbyStatus;
import '../blocs/lobby/lobby_bloc.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({super.key});

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  final _pinCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<LobbyBloc>().add(LobbyLoadOpenRequested());
  }

  @override
  void dispose() {
    _pinCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<LobbyBloc, LobbyState>(
          builder: (context, state) {
            final isPlay = state.activeTab == 'play';
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Лобби',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Найзуудтайгаа хамтдаа тоглоорой',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: AppTheme.warmGradient,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.warningOrange.withValues(alpha: 0.3),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.local_fire_department_rounded, color: Colors.white, size: 18),
                            SizedBox(width: 4),
                            Text('1250', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tab buttons
                  Row(
                    children: [
                      Expanded(
                        child: _TabButton(
                          label: 'Тоглох',
                          icon: Icons.play_arrow_rounded,
                          selected: isPlay,
                          gradient: AppTheme.primaryGradient,
                          onTap: () => context.read<LobbyBloc>().add(const LobbyTabChanged('play')),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _TabButton(
                          label: 'Үүсгэх',
                          icon: Icons.add_rounded,
                          selected: !isPlay,
                          gradient: AppTheme.purpleGradient,
                          onTap: () => context.read<LobbyBloc>().add(const LobbyTabChanged('create')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  if (isPlay) ...[
                    // PIN input
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF1E2A3D)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PIN кодоор нэгдэх',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _pinCtrl,
                                  decoration: const InputDecoration(
                                    hintText: 'PIN код оруулах...',
                                    prefixIcon: Icon(Icons.tag_rounded, size: 20),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 52,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: AppTheme.primaryGradient,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_pinCtrl.text.isNotEmpty) {
                                        context.read<LobbyBloc>().add(LobbyJoinByPinRequested(_pinCtrl.text.trim()));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: const Text('ОРОХ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Open lobbies header
                    Row(
                      children: [
                        Text(
                          'Нээлттэй тэмцээнүүд',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        if (state.openLobbies.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.accentCyan.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${state.openLobbies.length}',
                              style: TextStyle(
                                color: AppTheme.accentCyan,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    if (state.loading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else
                      ...state.openLobbies.map((l) => _LobbyCard(lobby: l)),
                  ] else
                    _CreateLobbyForm(state: state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.gradient,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: selected ? gradient : null,
          color: selected ? null : AppTheme.surfaceVariant,
          borderRadius: BorderRadius.circular(14),
          border: selected ? null : Border.all(color: const Color(0xFF1E2A3D)),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: gradient.colors.first.withValues(alpha: 0.25),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: selected ? Colors.white : AppTheme.textSecondary),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : AppTheme.textSecondary,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LobbyCard extends StatelessWidget {
  const _LobbyCard({required this.lobby});

  final LobbyModel lobby;

  @override
  Widget build(BuildContext context) {
    final isLive = lobby.status == LobbyStatus.live;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isLive
                ? AppTheme.successGreen.withValues(alpha: 0.2)
                : const Color(0xFF1E2A3D),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isLive
                        ? AppTheme.successGreen.withValues(alpha: 0.12)
                        : AppTheme.warningYellow.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isLive ? AppTheme.successGreen : AppTheme.warningYellow,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: (isLive ? AppTheme.successGreen : AppTheme.warningYellow)
                                  .withValues(alpha: 0.5),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isLive ? 'LIVE' : 'Удахгүй',
                        style: TextStyle(
                          fontSize: 11,
                          color: isLive ? AppTheme.successGreen : AppTheme.warningYellow,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Icon(Icons.people_rounded, size: 16, color: AppTheme.textMuted),
                const SizedBox(width: 4),
                Text(
                  '${lobby.participantCount}/${lobby.maxParticipants}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              lobby.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              lobby.organizerName,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _InfoChip(
                  icon: Icons.quiz_rounded,
                  label: '${lobby.questionCount} асуулт',
                ),
                const SizedBox(width: 8),
                if (lobby.startsAt != null)
                  _InfoChip(
                    icon: Icons.schedule_rounded,
                    label:
                        '${lobby.startsAt!.hour.toString().padLeft(2, '0')}:${lobby.startsAt!.minute.toString().padLeft(2, '0')}',
                  ),
                const Spacer(),
                SizedBox(
                  height: 38,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: isLive ? AppTheme.successGradient : AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: (isLive ? AppTheme.successGreen : AppTheme.accentCyan)
                              .withValues(alpha: 0.25),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: Text(
                        isLive ? 'Орох' : 'Нэгдэх',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.textMuted),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateLobbyForm extends StatefulWidget {
  const _CreateLobbyForm({required this.state});

  final LobbyState state;

  @override
  State<_CreateLobbyForm> createState() => _CreateLobbyFormState();
}

class _CreateLobbyFormState extends State<_CreateLobbyForm> {
  final _titleCtrl = TextEditingController(text: 'Математикийн тэмцээн');
  final _maxCtrl = TextEditingController(text: '20');
  bool _isPrivate = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _maxCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Шинэ лобби үүсгэх',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _titleCtrl,
          decoration: const InputDecoration(
            labelText: 'Лобби нэр',
            prefixIcon: Icon(Icons.title_rounded, size: 20),
          ),
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          initialValue: 'saved',
          decoration: const InputDecoration(
            labelText: 'Хичээлээс сонгох',
            prefixIcon: Icon(Icons.folder_outlined, size: 20),
          ),
          items: const [
            DropdownMenuItem(value: 'saved', child: Text('Хадгалсан Quiz-үүдээс сонгох')),
          ],
          onChanged: (_) {},
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _maxCtrl,
                decoration: const InputDecoration(
                  labelText: 'Хамгийн их хүн',
                  prefixIcon: Icon(Icons.people_outline_rounded, size: 20),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<bool>(
                initialValue: _isPrivate,
                decoration: const InputDecoration(
                  labelText: 'Төрөл',
                  prefixIcon: Icon(Icons.lock_outline_rounded, size: 20),
                ),
                items: const [
                  DropdownMenuItem(value: false, child: Text('Нээлттэй')),
                  DropdownMenuItem(value: true, child: Text('Хувийн')),
                ],
                onChanged: (v) => setState(() => _isPrivate = v ?? false),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: AppTheme.purpleGradient,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accentPurple.withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: widget.state.creating
                  ? null
                  : () {
                      context.read<LobbyBloc>().add(LobbyCreateRequested(
                            title: _titleCtrl.text.trim(),
                            quizOrLessonId: 'quiz-1',
                            maxParticipants: int.tryParse(_maxCtrl.text) ?? 20,
                            isPrivate: _isPrivate,
                          ));
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              icon: widget.state.creating
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.add_rounded, color: Colors.white),
              label: const Text(
                'Лобби үүсгэх',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Tips card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.accentPurple.withValues(alpha: 0.12),
                AppTheme.accentPink.withValues(alpha: 0.08),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.accentPurple.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ShaderMask(
                    shaderCallback: (b) => AppTheme.warmGradient.createShader(b),
                    child: const Icon(Icons.lightbulb_rounded, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Зөвлөмж',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _TipItem(text: 'Хувийн лобби үүсгэвэл PIN код автоматаар үүснэ'),
              _TipItem(text: 'Өөрийн Quiz-ээс сонгож болно'),
              _TipItem(text: 'Тоглогчид real-time тоглох боломжтой'),
              _TipItem(text: 'Шилдэг 3 тоглогч шагнал авна'),
            ],
          ),
        ),
      ],
    );
  }
}

class _TipItem extends StatelessWidget {
  const _TipItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: AppTheme.accentPurple,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
