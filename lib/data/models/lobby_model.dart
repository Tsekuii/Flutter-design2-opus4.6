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

  @override
  List<Object?> get props => [id, title, organizerName, participantCount, maxParticipants, questionCount, status, pin, type, startsAt];
}
