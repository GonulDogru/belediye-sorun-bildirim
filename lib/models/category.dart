import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 4)
class Category {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  /// UI için icon anahtarı (örn: "road", "trash", "light")
  @HiveField(3)
  final String iconKey;

  @HiveField(4)
  final bool isActive;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final DateTime updatedAt;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.iconKey,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
}
