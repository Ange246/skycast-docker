import 'package:flutter/material.dart';
import './weather_screen.dart';
import './locations_screen.dart';
import './favorites.dart'; // O 'favorites_screen.dart' según cómo lo hayas renombrado
import './settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // 1. Aquí se centraliza la lista real de tus favoritos
  final List<String> _misFavoritos = ['Orizaba', 'Tokyo'];

  // 2. Función para alternar favoritos (agregar/quitar) desde cualquier pantalla
  void _toggleFavorito(String ciudad) {
    setState(() {
      if (_misFavoritos.contains(ciudad)) {
        _misFavoritos.remove(ciudad);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$ciudad eliminada de favoritos 💔')),
        );
      } else {
        _misFavoritos.add(ciudad);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$ciudad añadida a favoritos ❤️')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 3. Reconstruimos la lista de pantallas pasando los datos dinámicos
    final List<Widget> pantallas = [
      WeatherScreen(
        favoritosActuales: _misFavoritos,
        onToggleFavorito: _toggleFavorito,
      ),
      const LocationsScreen(),
      FavoritesScreen(
        listaFavoritos: _misFavoritos,
        onEliminar: (ciudad) => _toggleFavorito(ciudad),
      ),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pantallas,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF6C63FF),
        unselectedItemColor: const Color(0xFF9CA3AF),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.wb_sunny_rounded), label: 'Clima'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Ubicaciones'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Sesión'),
        ],
      ),
    );
  }
}