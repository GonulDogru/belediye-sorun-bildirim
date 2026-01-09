import 'package:hive/hive.dart';

part 'announcement.g.dart';

@HiveType(typeId: 10)
class Announcement {
  @HiveField(0)
  final String id;

  /// FK -> AppUser.id (admin)
  @HiveField(1)
  final String createdByAdminId;

  /// FK -> Category.id (opsiyonel). Yoksa boş string tut.
  @HiveField(2)
  final String categoryId;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final String content;

  @HiveField(5)
  final bool isPublished;

  @HiveField(6)
  final DateTime? publishAt;

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final DateTime updatedAt;

  const Announcement({
    required this.id,
    required this.createdByAdminId,
    required this.categoryId,
    required this.title,
    required this.content,
    required this.isPublished,
    required this.publishAt,
    required this.createdAt,
    required this.updatedAt,
  });
}
