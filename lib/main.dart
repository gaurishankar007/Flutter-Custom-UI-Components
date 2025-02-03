import 'package:flutter/material.dart';
import 'package:ui_components/widgets/clippers/half_circle_widget.dart';

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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ),
                child: ClipPath(
                  clipper: HalfCircleClipper(side: CircleSide.left),
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
