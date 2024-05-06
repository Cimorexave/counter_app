import 'package:counter_app/model/profile.dart';
import 'package:counter_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.profile});
  final Profile? profile;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Box<Profile> profileBox = Hive.box<Profile>("profiles");
  // final Profile? profile = Hive.box<Profile>("profiles")
  //     .values
  //     .firstWhereOrNull((p) => p.isLastUsed);

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController goalController = TextEditingController();

  @override
  void initState() {
    if (widget.profile != null) {
      nameController = TextEditingController(text: widget.profile?.name);
      ageController =
          TextEditingController(text: widget.profile?.age.toString());
      heightController =
          TextEditingController(text: widget.profile?.height.toString());
      weightController =
          TextEditingController(text: widget.profile?.weight.toString());
      genderController = TextEditingController(text: widget.profile?.gender);
      goalController = TextEditingController(
          text: widget.profile?.goalCaloriesPerDay.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profile == null ? "Profile" : widget.profile!.name),
      ),
      body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // name
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                controller: nameController,
                validator: (value) {
                  if (value == null) return "name field can't be empty";
                  return null;
                },
              ),
              // age
              TextFormField(
                decoration: const InputDecoration(labelText: 'Age'),
                controller: ageController,
                validator: (value) {
                  if (value == null) return "age field can't be empty";
                  if (int.tryParse(value) == null) {
                    return "age field must be an integer";
                  }
                  return null;
                },
              ),
              // height
              TextFormField(
                decoration: const InputDecoration(labelText: 'Height'),
                controller: heightController,
                validator: (value) {
                  if (value == null) return "height field can't be empty";
                  if (int.tryParse(value) == null) {
                    return "height field must be an integer";
                  }
                  return null;
                },
              ),
              // weight
              TextFormField(
                decoration: const InputDecoration(labelText: 'Weight'),
                controller: weightController,
                validator: (value) {
                  if (value == null) return "weight field can't be empty";
                  if (int.tryParse(value) == null) {
                    return "weight field must be an integer";
                  }
                  return null;
                },
              ),
              // gender
              TextFormField(
                decoration: const InputDecoration(labelText: 'Gender'),
                controller: genderController,
                validator: (value) {
                  if (value == null) return "gender field can't be empty";
                  return null;
                },
              ),
              // goal calories per day
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Goal Calories Per Day'),
                controller: goalController,
                validator: (value) {
                  if (value == null) return "goal field can't be empty";
                  if (int.tryParse(value) == null) {
                    return "goal field must be an integer";
                  }
                  return null;
                },
              ),
              // buttons
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            // save/update profile
                            if (widget.profile == null) {
                              Profile newProfile = Profile(
                                name: nameController.text,
                                age: int.parse(ageController.text),
                                height: int.parse(heightController.text),
                                weight: int.parse(weightController.text),
                                goalCaloriesPerDay:
                                    int.parse(goalController.text),
                                gender: genderController.text,
                                id: generateRandomString(12),
                                isLastUsed: true,
                              );
                              profileBox.add(newProfile);
                            } else {
                              widget.profile?.name = nameController.text;
                              widget.profile?.age =
                                  int.parse(ageController.text);
                              widget.profile?.height =
                                  int.parse(heightController.text);
                              widget.profile?.weight =
                                  int.parse(weightController.text);
                              widget.profile?.goalCaloriesPerDay =
                                  int.parse(goalController.text);
                              widget.profile?.gender = genderController.text;

                              widget.profile!.save().whenComplete(() =>
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Successfully ${widget.profile == null ? "Added" : "Updated"} Profile'),
                                    backgroundColor: Colors.green,
                                  )));

                              Navigator.of(context).pop();
                            }
                          }
                        },
                        child: Text(widget.profile == null ? 'Add' : "Save")),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
