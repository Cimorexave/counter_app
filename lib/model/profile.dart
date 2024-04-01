import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Profile extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  int height;

  @HiveField(3)
  int weight;

  @HiveField(4)
  String gender;

  @HiveField(5)
  bool isLastUsed;

  @HiveField(6)
  String id;

  @HiveField(7)
  int goalCaloriesPerDay;

  Profile({
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.id,
    required this.goalCaloriesPerDay,
    this.isLastUsed = false,
  });
}
