import 'package:equatable/equatable.dart';

enum LobbyStatus { upcoming, live, ended }
enum LobbyType { open, private }

class LobbyModel extends Equatable {
  const LobbyModel({
    required this.id,
    required this.title,
    required this.organizerName,
    required this.participantCount,
    required this.maxParticipants,
    required this.questionCount,
    required this.status,
    this.pin,
    this.type = LobbyType.open,
    this.startsAt,
    this.hostId,
    this.quizId,
  });

  final String id;
  final String title;
  final String organizerName;
  final int participantCount;
  final int maxParticipants;
  final int questionCount;
  final LobbyStatus status;
  final String? pin;
  final LobbyType type;
  final DateTime? startsAt;
  final String? hostId;
  final String? quizId;

  // Parse from Supabase row
  factory LobbyModel.fromSupabase(Map<String, dynamic> json) {
    LobbyStatus parseStatus(String? s) {
      switch (s) {
        case 'live': return LobbyStatus.live;
        case 'ended': return LobbyStatus.ended;
        default: return LobbyStatus.upcoming;
      }
    }

    return LobbyModel(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      organizerName: json['host_display_name'] as String? ?? 'Тодорхойгүй',
      participantCount: json['participant_count'] as int? ?? 0,
      maxParticipants: json['max_participants'] as int? ?? 50,
      questionCount: 0, // load separately if needed
      status: parseStatus(json['status'] as String?),
      pin: json['pin'] as String?,
      type: (json['is_private'] == true) ? LobbyType.private : LobbyType.open,
      startsAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      hostId: json['host_id'] as String?,
      quizId: json['quiz_id'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    id, title, organizerName, participantCount,
    maxParticipants, questionCount, status, pin, type, startsAt,
  ];
}