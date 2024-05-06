import 'package:counter_app/model/profile.dart';
import 'package:counter_app/model/record.dart';
import 'package:counter_app/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final Box<Profile> profileBox = Hive.box<Profile>("profiles");
  final Box<Record> recordBox = Hive.box<Record>("records");

  @override
  Widget build(BuildContext context) {
    return profileBox.isNotEmpty
        ? ValueListenableBuilder(
            valueListenable: profileBox.listenable(),
            builder: (context, profileBox, _) => recordBox.isNotEmpty
                ? ValueListenableBuilder(
                    valueListenable: recordBox.listenable(),
                    builder: (context, recordBox, _) => Scaffold(
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {},
                        child: const Icon(Icons.add),
                      ),
                      appBar: AppBar(
                        title: const Text('Counter'),
                        actions: [
                          PopupMenuButton(
                            itemBuilder: (context) => profileBox.values
                                .map((p) => PopupMenuItem<Profile>(
                                    value: p,
                                    child: p.isLastUsed
                                        ? Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 4),
                                                child: const Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Text(p.name),
                                            ],
                                          )
                                        : Text(p.name)))
                                .toList(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    child: const Icon(Icons.person)),
                                Text(
                                    profileBox.values
                                        .firstWhere((e) => e.isLastUsed)
                                        .name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            // dropdownMenuEntries: profileBox.values
                            //     .map((p) =>
                            //         DropdownMenuEntry<Profile>(value: p, label: p.name))
                            //     .toList(),
                            // label: const Icon(Icons.account_circle),
                            onSelected: (Profile? selected) async {
                              if (selected != null) {
                                Profile oldProfile = profileBox.values
                                    .firstWhere((p) => p.isLastUsed);
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
                      body: const Center(
                        child: Text('Hello World!'),
                      ),
                    ),
                  )
                : Scaffold(
                    appBar: AppBar(
                      title: const Text("Counter"),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: PopupMenuButton(
                            itemBuilder: (context) => <PopupMenuEntry<Profile>>[
                              ...profileBox.values
                                  .map((p) => PopupMenuItem<Profile>(
                                      value: p,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          p.isLastUsed
                                              ? Row(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 4),
                                                      child: const Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                    Text(p.name),
                                                  ],
                                                )
                                              : Text(p.name),
                                          IconButton(
                                              padding: const EdgeInsets.all(4),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfilePage(
                                                              profile: p,
                                                            )));
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                size: 16.0,
                                              )),
                                        ],
                                      )))
                                  .toList(),
                              PopupMenuItem(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ProfilePage()));
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (context) => ProfileDialog(
                                    //           editingProfile: null,
                                    //         ));
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(Icons.add),
                                      Text('New'),
                                    ],
                                  )),
                            ],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    child: const Icon(Icons.person)),
                                Text(
                                    profileBox.values
                                        .firstWhere((e) => e.isLastUsed)
                                        .name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            onSelected: (Profile? selected) async {
                              if (selected != null && !selected.isLastUsed) {
                                Profile oldProfile = profileBox.values
                                    .firstWhere((p) => p.isLastUsed);
                                oldProfile.isLastUsed = false;
                                await oldProfile.save();
                                Profile newSelectedProfile = profileBox.values
                                    .firstWhere((p) => p.id == selected.id);
                                newSelectedProfile.isLastUsed = true;
                                await newSelectedProfile.save();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              'No Data to Show.\nStart Adding Records to see more information here'),
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: OutlinedButton(
                                onPressed: () {},
                                child: const Text('Add Record')),
                          )
                        ],
                      )),
                    ),
                  ))
        : Scaffold(
            appBar: AppBar(
              title: const Text("Counter"),
            ),
            body: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfilePage()));
                },
                child: const Text('Add Profile'),
              ),
            ),
          );
  }
}
