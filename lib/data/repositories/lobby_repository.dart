import '../models/lobby_model.dart';

/// Lobby list and create. Mock for frontend.
class LobbyRepository {
  final List<LobbyModel> _lobbies = [
    LobbyModel(
      id: 'l1',
      title: 'Монгол хэлний олимпиад',
      organizerName: 'Багш А.Болд',
      participantCount: 42,
      maxParticipants: 50,
      questionCount: 15,
      status: LobbyStatus.live,
    ),
    LobbyModel(
      id: 'l2',
      title: 'Мэдээлэл зүй: Python',
      organizerName: 'Сургууль 1',
      participantCount: 12,
      maxParticipants: 20,
      questionCount: 20,
      status: LobbyStatus.upcoming,
      startsAt: DateTime.now().add(const Duration(minutes: 5)),
    ),
    LobbyModel(
      id: 'l3',
      title: 'Ерөнхий Мэдлэг: Дэлхий',
      organizerName: 'Нийтийн нээлттэй өрөө',
      participantCount: 156,
      maxParticipants: 200,
      questionCount: 25,
      status: LobbyStatus.live,
    ),
  ];

  Future<List<LobbyModel>> getOpenLobbies({String? search}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    var list = List<LobbyModel>.from(_lobbies);
    if (search != null && search.isNotEmpty) {
      list = list.where((l) => l.title.toLowerCase().contains(search.toLowerCase())).toList();
    }
    return list;
  }

  Future<LobbyModel?> createLobby({
    required String title,
    required String quizOrLessonId,
    required int maxParticipants,
    required bool isPrivate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final pin = isPrivate ? '${1000 + _lobbies.length}' : null;
    final lobby = LobbyModel(
      id: 'lobby-${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      organizerName: 'Та',
      participantCount: 0,
      maxParticipants: maxParticipants,
      questionCount: 10,
      status: LobbyStatus.upcoming,
      pin: pin,
      type: isPrivate ? LobbyType.private : LobbyType.open,
      startsAt: DateTime.now(),
    );
    _lobbies.insert(0, lobby);
    return lobby;
  }

  Future<bool> joinByPin(String pin) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }
}
