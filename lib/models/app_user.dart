import 'package:hive/hive.dart';

part 'app_user.g.dart';

@HiveType(typeId: 2)
class AppUser {
  /// Primary key (Hive key olarak da bunu kullanmanı öneririm)
  /// Pratikte tc'yi id yapabilirsin (profile.tc ile eşleşir).
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  /// USER / ADMIN
  @HiveField(2)
  final String role;

  @HiveField(3)
  final bool isActive;

  /// Yerel giriş yapıyorsan kullan; kullanmıyorsan boş string tutabilirsin.
  @HiveField(4)
  final String passwordHash;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final DateTime updatedAt;

  const AppUser({
    required this.id,
    required this.email,
    required this.role,
    required this.isActive,
    required this.passwordHash,
    required this.createdAt,
    required this.updatedAt,
  });
}
