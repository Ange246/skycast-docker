import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Apartado: Ajustes y Sesión', style: TextStyle(fontSize: 18, color: Color(0xFF1F2937))),
    );
  }
}
