import 'package:hive/hive.dart';

part 'session.g.dart';

@HiveType(typeId: 3)
class Session {
  @HiveField(0)
  final String id;

  /// FK -> AppUser.id
  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String deviceId;

  @HiveField(3)
  final String deviceName;

  @HiveField(4)
  final DateTime lastLoginAt;

  @HiveField(5)
  final DateTime expiresAt;

  @HiveField(6)
  final bool isRevoked;

  const Session({
    required this.id,
    required this.userId,
    required this.deviceId,
    required this.deviceName,
    required this.lastLoginAt,
    required this.expiresAt,
    required this.isRevoked,
  });
}
