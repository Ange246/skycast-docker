import 'package:flutter/material.dart';

class LocationsScreen extends StatelessWidget {
  const LocationsScreen({Key? key}) : super(key: key);

  // Lista de ciudades globales predefinidas para explorar
  final List<Map<String, String>> ciudadesGlobales = const [
    {'ciudad': 'Tokyo', 'pais': 'Japón', 'icon': '🏙️'},
    {'ciudad': 'New York', 'pais': 'Estados Unidos', 'icon': '🗽'},
    {'ciudad': 'Paris', 'pais': 'Francia', 'icon': '🗼'},
    {'ciudad': 'London', 'pais': 'Reino Unido', 'icon': '🎡'},
    {'ciudad': 'Cairo', 'pais': 'Egipto', 'icon': '🏜️'},
    {'ciudad': 'Sydney', 'pais': 'Australia', 'icon': '🦘'},
    {'ciudad': 'Rio de Janeiro', 'pais': 'Brasil', 'icon': '🏖️'},
    {'ciudad': 'Reykjavik', 'pais': 'Islandia', 'icon': '❄️'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('Explorar el Mundo', style: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: ciudadesGlobales.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.3,
          ),
          itemBuilder: (context, index) {
            final lugar = ciudadesGlobales[index];
            return InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Consultando clima real para ${lugar['ciudad']}...')),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(lugar['icon']!, style: const TextStyle(fontSize: 28)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lugar['ciudad']!, style: const TextStyle(color: Color(0xFF1F2937), fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(lugar['pais']!, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}