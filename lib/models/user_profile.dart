import 'package:hive/hive.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 1)
class UserProfile {
  @HiveField(0)
  final String tc;

  @HiveField(1)
  final String fullName;

  UserProfile({required this.tc, required this.fullName});
}
