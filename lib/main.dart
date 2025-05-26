import 'package:flutter/material.dart';

import 'utils/screen_util/screen_util.dart';
import 'views/home_view.dart';

void main() {
  runApp(const CustomUIComponents());
}

class CustomUIComponents extends StatelessWidget {
  const CustomUIComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenUtil.I.configureScreen(constraints.biggest);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Custom UI Components',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomeView(),
        );
      },
    );
  }
}
