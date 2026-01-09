import 'package:hive/hive.dart';

part 'municipality_work.g.dart';

@HiveType(typeId: 9)
class MunicipalityWork {
  @HiveField(0)
  final String id;

  /// FK -> Category.id
  @HiveField(1)
  final String categoryId;

  /// FK -> AppUser.id (admin)
  @HiveField(2)
  final String createdByAdminId;

  /// FK -> Issue.id (opsiyonel). Yoksa boş string tut.
  @HiveField(3)
  final String relatedIssueId;

  @HiveField(4)
  final String title;

  @HiveField(5)
  final String description;

  /// PLANNED / ONGOING / COMPLETED
  @HiveField(6)
  final String status;

  @HiveField(7)
  final DateTime? startDate;

  @HiveField(8)
  final DateTime? endDate;

  @HiveField(9)
  final double? latitude;

  @HiveField(10)
  final double? longitude;

  @HiveField(11)
  final String addressText;

  @HiveField(12)
  final DateTime createdAt;

  @HiveField(13)
  final DateTime updatedAt;

  const MunicipalityWork({
    required this.id,
    required this.categoryId,
    required this.createdByAdminId,
    required this.relatedIssueId,
    required this.title,
    required this.description,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.latitude,
    required this.longitude,
    required this.addressText,
    required this.createdAt,
    required this.updatedAt,
  });
}
