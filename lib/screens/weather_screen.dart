import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/clima_dto.dart';

class WeatherScreen extends StatefulWidget {
  // VARIABLES AÑADIDAS PARA LOS FAVORITOS
  final List<String> favoritosActuales;
  final Function(String) onToggleFavorito;

  const WeatherScreen({
    Key? key,
    required this.favoritosActuales,
    required this.onToggleFavorito,
  }) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _searchController = TextEditingController();
  Future<ClimaDTO>? _climaFuture;

  @override
  void initState() {
    super.initState();
    // Carga inicial por defecto real
    _climaFuture = _weatherService.consultarClima('Orizaba');
  }

  void _ejecutarBusqueda() {
    if (_searchController.text.trim().isNotEmpty) {
      setState(() {
        _climaFuture = _weatherService.consultarClima(_searchController.text.trim());
      });
    }
  }

  Color _parseColor(String hex) {
    String cleanHex = hex.replaceAll('#', '');
    if (cleanHex.length == 6) cleanHex = 'FF$cleanHex';
    try {
      return Color(int.parse(cleanHex, radix: 16));
    } catch (_) {
      return const Color(0xFF6C63FF); // Color de respaldo
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFFF3F4F6); // Fondo claro elegante
    const Color cardColor = Colors.white;
    const Color textColor = Color(0xFF1F2937);
    const Color secondaryTextColor = Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // BARRA DE BÚSQUEDA
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onSubmitted: (_) => _ejecutarBusqueda(),
                  style: const TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: 'Buscar ciudad (Ej: Tokyo, Madrid)...',
                    hintStyle: TextStyle(color: secondaryTextColor.withOpacity(0.6)),
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search, color: secondaryTextColor, size: 20),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.arrow_forward_rounded, color: Color(0xFF6C63FF), size: 20),
                      onPressed: _ejecutarBusqueda,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ),

            // CONTENIDO ASÍNCRONO REAL
            Expanded(
              child: FutureBuilder<ClimaDTO>(
                future: _climaFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF6C63FF)));
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_off_outlined, color: Colors.redAccent.withOpacity(0.6), size: 50),
                          const SizedBox(height: 15),
                          const Text(
                            'Ciudad no encontrada',
                            style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Asegúrate de que el backend esté encendido.',
                            style: TextStyle(color: secondaryTextColor, fontSize: 13),
                          ),
                        ],
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: Text("Busca una ciudad del mundo..."));
                  }

                  final clima = snapshot.data!;
                  final colorDinamico = _parseColor(clima.colorHexadecimal);
                  
                  // Evaluamos si la ciudad consultada ya se encuentra guardada en la lista global
                  final bool esFavorito = widget.favoritosActuales.contains(clima.ciudad);

                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      // UBICACIÓN, FECHA Y CORAZÓN DE FAVORITOS
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${clima.ciudad}, ${clima.pais}', style: const TextStyle(color: textColor, fontSize: 26, fontWeight: FontWeight.bold)),
                                  Text('Estado actual del tiempo', style: TextStyle(color: secondaryTextColor.withOpacity(0.8), fontSize: 13)),
                                ],
                              ),
                              // ICONO INTERACTIVO DE CORAZÓN
                              IconButton(
                                icon: Icon(
                                  esFavorito ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                  color: esFavorito ? Colors.redAccent : secondaryTextColor,
                                  size: 28,
                                ),
                                onPressed: () {
                                  // Ejecuta el callback en MainNavigationScreen pasando la ciudad actual
                                  widget.onToggleFavorito(clima.ciudad);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      // PANEL CENTRAL MINIMALISTA
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${clima.temperatura}°',
                                      style: const TextStyle(color: textColor, fontSize: 86, fontWeight: FontWeight.w100, height: 1),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(clima.descripcion, style: const TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              if (clima.iconoUrl.isNotEmpty)
                                Image.network(clima.iconoUrl, width: 110, height: 110, fit: BoxFit.contain),
                            ],
                          ),
                        ),
                      ),

                      // METRICAS: HUMEDAD Y VIENTO
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              Expanded(child: _buildDetailCard(Icons.water_drop_outlined, '${clima.humidity}%', 'Humedad', cardColor, textColor, secondaryTextColor)),
                              const SizedBox(width: 15),
                              Expanded(child: _buildDetailCard(Icons.air, '${clima.viento.toStringAsFixed(1)} km/h', 'Viento', cardColor, textColor, secondaryTextColor)),
                            ],
                          ),
                        ),
                      ),

                      // TARJETA DE RECOMENDACIÓN RE-ESTILIZADA
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.all(25),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: colorDinamico.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: colorDinamico.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.lightbulb_outline, color: colorDinamico, size: 24),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(clima.recomendacion, style: const TextStyle(color: textColor, fontSize: 13, height: 1.4, fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // PRONÓSTICO POR HORA HORIZONTAL
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 25.0, bottom: 15),
                              child: Text('Próximas Horas', style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 110,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                itemCount: clima.pronosticoHoras.length,
                                itemBuilder: (context, index) {
                                  final hora = clima.pronosticoHoras[index];
                                  return Container(
                                    width: 80,
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: cardColor,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(hora.hora, style: const TextStyle(color: secondaryTextColor, fontSize: 12)),
                                        Image.network(hora.iconoUrl, width: 32, height: 32),
                                        Text('${hora.temp}°', style: const TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // PRONÓSTICO SEMANAL VERTICAL
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 25.0, top: 30, bottom: 15),
                              child: Text('Pronóstico Semanal', style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              itemCount: clima.pronosticoDias.length,
                              itemBuilder: (context, index) {
                                final dia = clima.pronosticoDias[index];
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 6),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                  decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(dia.dia, style: const TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w600)),
                                      ),
                                      Image.network(dia.iconoUrl, width: 30, height: 30),
                                      Expanded(
                                        child: Text(
                                          '${dia.tempMax}°',
                                          style: const TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 30)),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(IconData icon, String value, String label, Color cardColor, Color textColor, Color secondaryTextColor) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFF6C63FF).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: const Color(0xFF6C63FF), size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value, style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.bold)),
              Text(label, style: TextStyle(color: secondaryTextColor, fontSize: 11, fontWeight: FontWeight.w500)),
            ],
          )
        ],
      ),
    );
  }
}