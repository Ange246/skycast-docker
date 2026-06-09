import 'package:flutter/material.dart';
import 'screens/main_navigation_screen.dart'; // Cambiamos el import a la pantalla de navegación central

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkyCast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Mantenemos la paleta limpia y estilizada para el diseño 'Global Connect'
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF3F4F6), 
      ),
      // Apuntamos al menú de navegación que orquesta las 4 pestañas
      home: const MainNavigationScreen(), 
    );
  }
}