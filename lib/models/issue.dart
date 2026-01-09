import 'package:hive/hive.dart';

part 'issue.g.dart';

@HiveType(typeId: 5)
class Issue {
  @HiveField(0)
  final String id;

  /// FK -> AppUser.id (bildiren kullanıcı)
  @HiveField(1)
  final String userId;

  /// FK -> Category.id
  @HiveField(2)
  final String categoryId;

  /// FK -> AppUser.id (admin). Atanmadıysa boş string tut.
  @HiveField(3)
  final String assignedAdminId;

  /// FK -> MunicipalityWork.id. İlişkili çalışma yoksa boş string tut.
  @HiveField(4)
  final String relatedWorkId;

  @HiveField(5)
  final String title;

  @HiveField(6)
  final String description;

  /// OPEN / IN_REVIEW / IN_PROGRESS / RESOLVED / REJECTED
  @HiveField(7)
  final String status;

  /// LOW / MEDIUM / HIGH
  @HiveField(8)
  final String priority;

  @HiveField(9)
  final double latitude;

  @HiveField(10)
  final double longitude;

  @HiveField(11)
  final String addressText;

  @HiveField(12)
  final DateTime createdAt;

  @HiveField(13)
  final DateTime updatedAt;

  /// Kapandıysa dolu, değilse null
  @HiveField(14)
  final DateTime? closedAt;

  const Issue({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.assignedAdminId,
    required this.relatedWorkId,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.latitude,
    required this.longitude,
    required this.addressText,
    required this.createdAt,
    required this.updatedAt,
    required this.closedAt,
  });
}
