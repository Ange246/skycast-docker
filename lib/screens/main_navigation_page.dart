import 'package:flutter/material.dart';
import 'weather_page.dart';
import 'ubicaciones_page.dart';
import 'favoritos_page.dart';
import 'ajustes_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const WeatherPage(),
    const UbicacionesPage(),
    const FavoritosPage(),
    const AjustesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF0D0E15),
          selectedItemColor: const Color(0xFF8B5CF6),
          unselectedItemColor: Colors.white24,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.wb_cloudy_outlined), activeIcon: Icon(Icons.wb_cloudy_rounded), label: 'Clima'),
            BottomNavigationBarItem(icon: Icon(Icons.map_outlined), activeIcon: Icon(Icons.map_rounded), label: 'Explorar'),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark_border_rounded), activeIcon: Icon(Icons.bookmark_rounded), label: 'Favoritos'),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings_rounded), label: 'Ajustes'),
          ],
        ),
      ),
    );
  }
}
