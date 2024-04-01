import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class Record extends HiveObject {
  @HiveField(0)
  String profileId;

  @HiveField(1)
  DateTime time;

  @HiveField(2)
  int calories;

  @HiveField(3)
  String description;

  @HiveField(4)
  String id;

  Record({
    required this.profileId,
    required this.time,
    required this.calories,
    required this.id,
    this.description = "",
  });
}
