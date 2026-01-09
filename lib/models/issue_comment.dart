import 'package:hive/hive.dart';

part 'issue_comment.g.dart';

@HiveType(typeId: 8)
class IssueComment {
  @HiveField(0)
  final String id;

  /// FK -> Issue.id
  @HiveField(1)
  final String issueId;

  /// FK -> AppUser.id (yorum yapan)
  @HiveField(2)
  final String userId;

  @HiveField(3)
  final String message;

  /// Admin iç notu gibi düşün (opsiyonel)
  @HiveField(4)
  final bool isInternal;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final DateTime? updatedAt;

  const IssueComment({
    required this.id,
    required this.issueId,
    required this.userId,
    required this.message,
    required this.isInternal,
    required this.createdAt,
    required this.updatedAt,
  });
}
