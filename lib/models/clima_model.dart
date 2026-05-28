class ClimaDTO {
  final String ciudad;
  final double temperatura;
  final int humidity;
  final String descripcion;
  final String iconoUrl;
  final String recomendacion;
  final String colorHexadecimal;

  ClimaDTO({
    required this.ciudad,
    required this.temperatura,
    required this.humidity,
    required this.descripcion,
    required this.iconoUrl,
    required this.recomendacion,
    required this.colorHexadecimal,
  });

  // Fábrica para convertir el JSON del backend a un objeto Dart
  factory ClimaDTO.fromJson(Map<String, dynamic> json) {
    return ClimaDTO(
      ciudad: json['ciudad'] ?? 'Desconocido',
      temperatura: (json['temperatura'] as num).toDouble(),
      humidity: json['humidity'] ?? 0,
      descripcion: json['descripcion'] ?? '',
      iconoUrl: json['iconoUrl'] ?? 'https://openweathermap.org/img/wn/01d@2x.png',
      recomendacion: json['recomendacion'] ?? '',
      colorHexadecimal: json['colorHexadecimal'] ?? '#2C3E50',
    );
  }
}
