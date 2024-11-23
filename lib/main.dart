import 'package:flutter/material.dart';
import 'package:ui_components/painter/dotted_circle_widget.dart';

void main() {
  runApp(const CustomUIComponents());
}

class CustomUIComponents extends StatelessWidget {
  const CustomUIComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Custom UI Components',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: const Column(
          children: [
            SizedBox(width: double.maxFinite, height: 100),
            DottedCircleWidget(
              radius: 100,
              color: Colors.purple,
              dotsNumber: 8,
            )
          ],
        ),
      ),
    );
  }
}
