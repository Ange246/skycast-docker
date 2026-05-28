import 'package:flutter/material.dart';
import '../database/local_database.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({super.key});

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mis Favoritos', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Icon(Icons.bookmark_rounded, color: Color(0xFF8B5CF6)),
              ],
            ),
            const SizedBox(height: 20),
            LocalDatabase.listaFavoritos.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Text(
                        'No has agregado favoritos.\nUsa el ícono en la pestaña Clima.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white38),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: LocalDatabase.listaFavoritos.length,
                      itemBuilder: (context, index) {
                        final ciudadFav = LocalDatabase.listaFavoritos[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF12141C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(ciudadFav.ciudad, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  Text(ciudadFav.pais, style: const TextStyle(color: Colors.white38, fontSize: 12)),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.network(ciudadFav.iconoUrl, width: 40),
                                  Text('${ciudadFav.temperatura.round()}°', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                    onPressed: () {
                                      setState(() {
                                        LocalDatabase.listaFavoritos.removeAt(index);
                                      });
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
