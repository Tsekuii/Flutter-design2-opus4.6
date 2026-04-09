import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/lobby_model.dart';

class LobbyRepository {
  final _supabase = Supabase.instance.client;

  String? get _userId => _supabase.auth.currentUser?.id;

  // Get all open/upcoming lobbies (for the lobby list screen)
  Future<List<LobbyModel>> getOpenLobbies({String? search}) async {
    var query = _supabase
        .from('lobbies')
        .select()
        .inFilter('status', ['upcoming', 'live'])
        .order('created_at', ascending: false)
        .limit(30);

    final data = await query;
    var lobbies = (data as List).map((e) => LobbyModel.fromSupabase(e)).toList();

    if (search != null && search.isNotEmpty) {
      lobbies = lobbies
          .where((l) => l.title.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
    return lobbies;
  }

  // Create a new lobby (teacher or student creates a room)
  Future<LobbyModel?> createLobby({
    required String title,
    required String quizOrLessonId,
    required int maxParticipants,
    required bool isPrivate,
  }) async {
    final userId = _userId;
    if (userId == null) return null;

    // Get host display name
    final profileData = await _supabase
        .from('profiles')
        .select('display_name')
        .eq('id', userId)
        .single();
    final hostName = profileData['display_name'] as String? ?? '';

    // Generate 4-digit PIN for private lobbies
    final pin = isPrivate
        ? (1000 + DateTime.now().millisecond % 9000).toString()
        : null;

    final data = await _supabase.from('lobbies').insert({
      'title': title,
      'quiz_id': quizOrLessonId.isEmpty ? null : quizOrLessonId,
      'host_id': userId,
      'host_display_name': hostName,
      'status': 'upcoming',
      'max_participants': maxParticipants,
      'is_private': isPrivate,
      'pin': pin,
      'participant_count': 0,
    }).select().single();

    // Host automatically joins their own lobby
    await _joinLobby(data['id'] as String);

    return LobbyModel.fromSupabase(data);
  }

  // Join by PIN (private lobby)
  Future<bool> joinByPin(String pin) async {
    try {
      final data = await _supabase
          .from('lobbies')
          .select()
          .eq('pin', pin)
          .inFilter('status', ['upcoming', 'live'])
          .maybeSingle();

      if (data == null) return false;
      await _joinLobby(data['id'] as String);
      return true;
    } catch (_) {
      return false;
    }
  }

  // Join a lobby by ID (open lobby)
  Future<bool> joinLobbyById(String lobbyId) async {
    try {
      await _joinLobby(lobbyId);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _joinLobby(String lobbyId) async {
    final userId = _userId;
    if (userId == null) return;
    // upsert = insert if not exists, ignore if already joined
    await _supabase.from('lobby_participants').upsert({
      'lobby_id': lobbyId,
      'user_id': userId,
      'score': 0,
    }, onConflict: 'lobby_id,user_id');
  }

  // Update score when quiz finishes inside a lobby
  Future<void> submitScore(String lobbyId, int score) async {
    final userId = _userId;
    if (userId == null) return;
    await _supabase
        .from('lobby_participants')
        .update({'score': score})
        .eq('lobby_id', lobbyId)
        .eq('user_id', userId);
  }

  // Get all participants in a lobby (with their scores and names)
  Future<List<Map<String, dynamic>>> getLobbyParticipants(String lobbyId) async {
    final data = await _supabase
        .from('lobby_participants')
        .select('score, joined_at, profiles(display_name, level, avatar_url)')
        .eq('lobby_id', lobbyId)
        .order('score', ascending: false);
    return List<Map<String, dynamic>>.from(data as List);
  }

  // REALTIME: Subscribe to live participant updates in a lobby
  // Call this when user enters a lobby room
  RealtimeChannel subscribeToLobby({
    required String lobbyId,
    required void Function(List<Map<String, dynamic>> participants) onUpdate,
  }) {
    return _supabase
        .channel('lobby-$lobbyId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'lobby_participants',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'lobby_id',
            value: lobbyId,
          ),
          callback: (payload) async {
            // Reload full participant list on any change
            final participants = await getLobbyParticipants(lobbyId);
            onUpdate(participants);
          },
        )
        .subscribe();
  }

  // REALTIME: Subscribe to lobby list updates (for the lobby browser)
  RealtimeChannel subscribeToLobbyList({
    required void Function() onUpdate,
  }) {
    return _supabase
        .channel('lobby-list')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'lobbies',
          callback: (_) => onUpdate(),
        )
        .subscribe();
  }

  // Start a lobby (host only)
  Future<void> startLobby(String lobbyId) async {
    await _supabase
        .from('lobbies')
        .update({'status': 'live'})
        .eq('id', lobbyId)
        .eq('host_id', _userId ?? '');
  }

  // End a lobby (host only)
  Future<void> endLobby(String lobbyId) async {
    await _supabase
        .from('lobbies')
        .update({'status': 'ended'})
        .eq('id', lobbyId)
        .eq('host_id', _userId ?? '');
  }
}