import 'package:flutter/material.dart';
import 'screens/main_navigation_page.dart';

void main() {
  runApp(const SkycastApp());
}

class SkycastApp extends StatelessWidget {
  const SkycastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkyCast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0C10),
      ),
      home: const MainNavigationPage(),
    );
  }
}
