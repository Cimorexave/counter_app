import 'dart:io';

import 'package:counter_app/model/profile.dart';
import 'package:counter_app/model/record.dart';
import 'package:counter_app/pages/home.dart';
import 'package:counter_app/pages/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void main() async {
  // init hive
  if (!kIsWeb) {
    if (Platform.isAndroid) {
      Directory appDocumentDirectory = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);
    } else {
      Hive.initFlutter();
    }
  }

  // register adapters
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(RecordAdapter());

  // open boxes
  await Hive.openBox<Profile>('profiles');
  await Hive.openBox<Record>('records');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Home(),
        '/profile': (context) => ProfilePage(),
      },
      initialRoute: Hive.box<Profile>("profiles")
              .values
              .any((element) => element.isLastUsed)
          ? "/profile"
          : "/",
      home: Home(),
    );
  }
}
