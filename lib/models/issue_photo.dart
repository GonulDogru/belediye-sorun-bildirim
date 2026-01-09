import 'package:hive/hive.dart';

part 'issue_photo.g.dart';

@HiveType(typeId: 6)
class IssuePhoto {
  @HiveField(0)
  final String id;

  /// FK -> Issue.id
  @HiveField(1)
  final String issueId;

  /// Cihaz içi foto dosya yolu
  @HiveField(2)
  final String localPath;

  @HiveField(3)
  final String caption;

  /// Foto çekim zamanı (opsiyonel)
  @HiveField(4)
  final DateTime? takenAt;

  @HiveField(5)
  final DateTime createdAt;

  /// Opsiyonel: foto metadatası
  @HiveField(6)
  final double? lat;

  @HiveField(7)
  final double? lng;

  const IssuePhoto({
    required this.id,
    required this.issueId,
    required this.localPath,
    required this.caption,
    required this.takenAt,
    required this.createdAt,
    required this.lat,
    required this.lng,
  });
}
