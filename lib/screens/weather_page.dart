import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../database/local_database.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _controller = TextEditingController();
  WeatherModel _ciudadActual = LocalDatabase.listaCiudadesTotal[0];

  void _ejecutarBusqueda() {
    final query = _controller.text.trim().toLowerCase();
    if (query.isEmpty) return;

    try {
      final encontrada = LocalDatabase.listaCiudadesTotal.firstWhere(
        (element) => element.ciudad.toLowerCase() == query
      );
      setState(() {
        _ciudadActual = encontrada;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"$query" no encontrada en la simulación.'),
          backgroundColor: Colors.amber[800],
        ),
      );
    }
  }

  void _agregarAFavoritos() {
    if (LocalDatabase.listaFavoritos.contains(_ciudadActual)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Esta ciudad ya está en tus favoritos.')),
      );
    } else {
      setState(() {
        LocalDatabase.listaFavoritos.add(_ciudadActual);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_ciudadActual.ciudad} agregada a Favoritos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = const [Color(0xFF1E1E2E), Color(0xFF12141C)];
    if (_ciudadActual.condition == 'thunderstorm' || _ciudadActual.condition == 'rain') {
      gradientColors = const [Color(0xFF1A263F), Color(0xFF0F111A)];
    } else if (_ciudadActual.condition == 'clear') {
      gradientColors = const [Color(0xFF2E1A47), Color(0xFF12141C)];
    }

    String saludoUsuario = LocalDatabase.usuarioLogueado != null 
        ? 'Hi ${LocalDatabase.usuarioLogueado!.username}!'
        : 'Welcome Guest!';

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(saludoUsuario, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const Text('Descubre el clima actual', style: TextStyle(color: Colors.white38, fontSize: 13)),
                  ],
                ),
                IconButton(
                  onPressed: _agregarAFavoritos,
                  icon: Icon(
                    LocalDatabase.listaFavoritos.contains(_ciudadActual)
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    color: const Color(0xFF8B5CF6),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),

            // Buscador
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: const Color(0xFF12141C), borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Buscar ciudad (Ej: Madrid, Paris, Monterrey)...',
                  hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
                  border: InputBorder.none,
                  icon: const Icon(Icons.search, color: Colors.white24, size: 20),
                  suffixIcon: IconButton(
                    onPressed: _ejecutarBusqueda,
                    icon: const Icon(Icons.send_rounded, color: Color(0xFF8B5CF6), size: 18),
                  ),
                ),
                onSubmitted: (_) => _ejecutarBusqueda(),
              ),
            ),
            const SizedBox(height: 24),

            // Tarjeta Principal
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
              ),
              child: Column(
                children: [
                  Text(_ciudadActual.ciudad, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(_ciudadActual.pais, style: const TextStyle(color: Colors.white54, fontSize: 13)),
                  Image.network(_ciudadActual.iconoUrl, width: 110, height: 110),
                  Text('${_ciudadActual.temperatura.round()}°', style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold)),
                  Text(_ciudadActual.descripcion.toUpperCase(), style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.water_drop_outlined, color: Colors.white38, size: 18),
                          Text('${_ciudadActual.humidity}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          const Text('Humedad', style: TextStyle(color: Colors.white38, fontSize: 11)),
                        ],
                      ),
                      const Column(
                        children: [
                          Icon(Icons.air_rounded, color: Colors.white38, size: 18),
                          Text('12 km/h', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text('Viento', style: TextStyle(color: Colors.white38, fontSize: 11)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // SECCIÓN NUEVA 1: CLIMA POR HORA
            const Text('Pronóstico por Hora', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _ciudadActual.pronosticoHoras.length,
                itemBuilder: (context, index) {
                  final horaItem = _ciudadActual.pronosticoHoras[index];
                  return Container(
                    width: 75,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF12141C),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(horaItem.hora, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                        Image.network(horaItem.iconoUrl, width: 40, height: 40),
                        Text('${horaItem.temperatura.round()}°', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // SECCIÓN NUEVA 2: CLIMA PRÓXIMOS DÍAS
            const Text('Próximos Días', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _ciudadActual.pronosticoDias.length,
                itemBuilder: (context, index) {
                  final diaItem = _ciudadActual.pronosticoDias[index];
                  return Container(
                    width: 110,
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF12141C),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(diaItem.dia, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Image.network(diaItem.iconoUrl, width: 36, height: 36),
                        Text(diaItem.descripcion, style: const TextStyle(color: Colors.white38, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis),
                        Text('${diaItem.temperaturaMax.round()}° / ${diaItem.temperaturaMin.round()}°', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Recomendación de IA
            const Text('Recomendación de IA', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF8B5CF6).withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.4)),
              ),
              child: Text(_ciudadActual.recomendacion, style: const TextStyle(color: Colors.white70, height: 1.4, fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}
