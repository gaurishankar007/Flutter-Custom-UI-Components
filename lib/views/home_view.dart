import 'package:flutter/material.dart';

import '../widgets/clippers/half_circle_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: ClipPath(
                clipper: HalfCircleClipper(side: CircleSide.left),
                child: Container(height: 200, width: 200, color: Colors.amber),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
