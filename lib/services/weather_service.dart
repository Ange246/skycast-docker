import 'import:http/http.dart' as http;
import 'dart:convert';
import '../models/clima_model.dart';

class WeatherService {
  // Cambia '10.0.2.2' por la IP de tu laptop si usas celular físico
  final String _baseUrl = 'http://10.0.2.2:8080/api/v1/weather';

  Future<ClimaDTO> consultarClima(String ciudad) async {
    final url = Uri.parse('$_baseUrl/$ciudad');
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Decodifica el texto en UTF-8 para evitar problemas con acentos o la 'ñ'
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return ClimaDTO.fromJson(data);
      } else {
        throw Exception('Error al obtener el clima: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('No se pudo conectar al backend: $e');
    }
  }
}
