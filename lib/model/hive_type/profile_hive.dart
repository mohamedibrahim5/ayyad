import 'package:hive/hive.dart';

part 'profile_hive.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  User(this.name, this.age);
}