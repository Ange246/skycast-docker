import 'package:flutter/material.dart';
import '../database/local_database.dart';

class UbicacionesPage extends StatelessWidget {
  const UbicacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Popular Locations', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 18),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.1,
                ),
                itemCount: LocalDatabase.listaCiudadesTotal.length,
                itemBuilder: (context, index) {
                  final loc = LocalDatabase.listaCiudadesTotal[index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF12141C), borderRadius: BorderRadius.circular(22)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${loc.temperatura.round()}°', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                            Image.network(loc.iconoUrl, width: 34),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(loc.descripcion, style: const TextStyle(color: Colors.white38, fontSize: 12)),
                            Text(loc.ciudad, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
