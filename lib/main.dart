import 'package:flutter/material.dart';

import 'user_inputs/drop_down_bottom_sheet_widget.dart';

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
              DropdownBottomSheetWidget(
                title: "Select a color",
                items: const [
                  DropdownItem(value: 0, label: "Unknown"),
                  DropdownItem(value: 1, label: "White"),
                  DropdownItem(value: 2, label: "Black"),
                  DropdownItem(value: 3, label: "Red"),
                ],
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
