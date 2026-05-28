import 'package:flutter/material.dart';
import '../models/clima_model.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _controller = TextEditingController();
  ClimaDTO? _climaActual;
  bool _cargando = false;
  String _errorMsg = '';

  void _buscarClima() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _cargando = true;
      _errorMsg = '';
      _climaActual = null;
    });

    try {
      final clima = await _weatherService.consultarClima(_controller.text.trim());
      setState(() {
        _climaActual = clima;
      });
    } catch (e) {
      setState(() {
        _errorMsg = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      setState(() {
        _cargando = false;
      });
    }
  }

  // Convierte el String Hexadecimal (#2C3E50) a un objeto Color de Flutter
  Color _getHexColor(String hex) {
    final String cleanHex = hex.replaceAll('#', '');
    return Color(int.parse('FF$cleanHex', radius: 16));
  }

  @override
  Widget build(BuildContext context) {
    final Color colorFondo = _climaActual != null 
        ? _getHexColor(_climaActual!.colorHexadecimal)
        : const Color(0xff111827);

    return Scaffold(
      backgroundColor: colorFondo,
      appBar: AppBar(
        title: const Text('Skycast Demo'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Buscador
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Escribe una ciudad (ej. Mexico)...',
                hintStyle: const TextStyle(color: Colors.white60),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: _buscarClima,
                ),
              ),
              onSubmitted: (_) => _buscarClima(),
            ),
            const SizedBox(height: 40),

            // Contenido dinámico
            if (_cargando) const CircularProgressIndicator(color: Colors.white),
            
            if (_errorMsg.isNotEmpty) 
              Text(_errorMsg, style: const TextStyle(color: Colors.redAccent, fontSize: 16)),

            if (_climaActual != null) ...[
              Text(_climaActual!.ciudad, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Image.network(_climaActual!.iconoUrl, width: 100, height: 100),
              Text('${_climaActual!.temperatura}°C', style: const TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.w300)),
              Text(_climaActual!.descripcion, style: const TextStyle(color: Colors.white70, fontSize: 20, fontStyle: FontStyle.italic)),
              const SizedBox(height: 10),
              Text('Humedad: ${_climaActual!.humidity}%', style: const TextStyle(color: Colors.white60, fontSize: 16)),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _climaActual!.recomendacion,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
