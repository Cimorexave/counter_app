import 'package:counter_app/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  // init hive

  // register adapters

  // open boxes

  // select profile

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
