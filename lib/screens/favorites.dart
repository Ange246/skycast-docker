import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<String> listaFavoritos;
  final Function(String) onEliminar;

  const FavoritesScreen({
    Key? key,
    required this.listaFavoritos,
    required this.onEliminar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('Mis Ciudades Favoritas', style: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: listaFavoritos.isEmpty
          ? const Center(
              child: Text('No has seleccionado ciudades favoritas todavía.', style: TextStyle(color: Colors.black45)),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: listaFavoritos.length,
              itemBuilder: (context, index) {
                final ciudad = listaFavoritos[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFEEEEFF),
                      child: Icon(Icons.location_city, color: Color(0xFF6C63FF)),
                    ),
                    title: Text(ciudad, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      onPressed: () => onEliminar(ciudad),
                    ),
                  ),
                );
              },
            ),
    );
  }
}