import 'package:counter_app/model/profile.dart';
import 'package:counter_app/model/record.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final Box<Profile> profileBox = Hive.box<Profile>("profiles");
  final Box<Record> recordBox = Hive.box<Record>("records");

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: profileBox.listenable(),
      builder: (context, profileBox, _) => ValueListenableBuilder(
        valueListenable: recordBox.listenable(),
        builder: (context, recordBox, _) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text('Counter'),
            actions: [
              DropdownMenu(
                dropdownMenuEntries: profileBox.values
                    .map((p) =>
                        DropdownMenuEntry<Profile>(value: p, label: p.name))
                    .toList(),
                label: const Icon(Icons.account_circle),
                onSelected: (Profile? selected) async {
                  if (selected != null) {
                    Profile oldProfile =
                        profileBox.values.firstWhere((p) => p.isLastUsed);
                    oldProfile.isLastUsed = false;
                    await oldProfile.save();
                    Profile newSelectedProfile = profileBox.values
                        .firstWhere((p) => p.id == selected.id);
                    newSelectedProfile.isLastUsed = true;
                    await newSelectedProfile.save();
                  }
                },
              ),
            ],
          ),
          body: Center(
            child: Text('Hello World!'),
          ),
        ),
      ),
    );
  }
}
