import 'package:hive/hive.dart';

part 'issue_status_history.g.dart';

@HiveType(typeId: 7)
class IssueStatusHistory {
  @HiveField(0)
  final String id;

  /// FK -> Issue.id
  @HiveField(1)
  final String issueId;

  /// FK -> AppUser.id (admin veya kullanıcı)
  @HiveField(2)
  final String changedByUserId;

  @HiveField(3)
  final String fromStatus;

  @HiveField(4)
  final String toStatus;

  /// Admin notu / açıklama
  @HiveField(5)
  final String note;

  @HiveField(6)
  final DateTime changedAt;

  const IssueStatusHistory({
    required this.id,
    required this.issueId,
    required this.changedByUserId,
    required this.fromStatus,
    required this.toStatus,
    required this.note,
    required this.changedAt,
  });
}
