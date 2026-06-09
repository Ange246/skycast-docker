import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/clima_dto.dart';

class WeatherService {
  // Recuerda usar 'localhost' si ejecutas en Chrome. 
  // Si llegas a probar en un celular físico, cámbialo por la IP de tu Lenovo (ej: 'http://192.168.1.X:8080...')
  final String baseUrl = 'http://localhost:8080/api/v1/weather';

  Future<ClimaDTO> consultarClima(String ciudad) async {
    final urlCompleta = Uri.parse('$baseUrl/$ciudad');
    
    try {
      final response = await http.get(urlCompleta);

      if (response.statusCode == 200) {
        // utf8.decode es clave para que los acentos y eñes de las ciudades no se rompan
        final datosDecodificados = jsonDecode(utf8.decode(response.bodyBytes));
        return ClimaDTO.fromJson(datosDecodificados);
      } else {
        throw Exception('No se encontraron datos para la ciudad: $ciudad');
      }
    } catch (e) {
      throw Exception('Error de conexión con el backend de SkyWest: $e');
    }
  }
}