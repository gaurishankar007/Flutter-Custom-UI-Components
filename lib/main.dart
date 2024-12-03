import 'package:flutter/material.dart';

import 'user_inputs/drop_down_menu_widget.dart';

void main() {
  runApp(const CustomUIComponents());
}

class CustomUIComponents extends StatelessWidget {
  const CustomUIComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Custom UI Components',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("UI Components"),
          backgroundColor: Colors.purple,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(width: double.maxFinite, height: 10),
              DropDownMenuWidget(
                width: MediaQuery.of(context).size.width - 40,
                enableFilter: false,
                controller: TextEditingController(),
                initialSelection: 1,
                entries: const [
                  DropdownMenuEntry(value: 0, label: "Unknown"),
                  DropdownMenuEntry(value: 1, label: "White"),
                  DropdownMenuEntry(value: 2, label: "Black"),
                  DropdownMenuEntry(value: 3, label: "Red"),
                ],
                onSelected: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
