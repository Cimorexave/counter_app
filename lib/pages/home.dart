import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Counter'),
        actions: [
          // DropdownMenu(dropdownMenuEntries: dropdownMenuEntries),
        ],
      ),
      body: Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
