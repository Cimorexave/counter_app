import 'package:counter_app/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Box<Profile> profileBox = Hive.box<Profile>("profiles");
  final Profile? profile = Hive.box<Profile>("profiles")
      .values
      .firstWhereOrNull((p) => p.isLastUsed);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: profileBox.listenable(),
      builder: (BuildContext context, Box<Profile> profileBox, _) => Scaffold(
        appBar: AppBar(
          title: Text(profile == null ? "Profile" : profile!.name),
        ),
      ),
    );
  }
}
