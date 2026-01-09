import 'package:hive/hive.dart';

part 'issue_model.g.dart';

@HiveType(typeId: 0)
class IssueModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String imagePath;

  @HiveField(3)
  final double latitude;

  @HiveField(4)
  final double longitude;

  @HiveField(5)
  final String address;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final String status; // 👈 YENİ ALAN

  IssueModel({
    required this.id,
    required this.description,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.createdAt,
    required this.status,
  });
}
