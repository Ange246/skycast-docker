class ClimaDTO {
  final String ciudad;
  final String pais;
  final int temperatura;
  final String descripcion;
  final String iconoUrl;
  final int humidity;
  final double viento;
  final String recomendacion;
  final String colorHexadecimal;
  final List<HoraPronostico> pronosticoHoras;
  final List<DiaPronostico> pronosticoDias;

  ClimaDTO({
    required this.ciudad,
    required this.pais,
    required this.temperatura,
    required this.descripcion,
    required this.iconoUrl,
    required this.humidity,
    required this.viento,
    required this.recomendacion,
    required this.colorHexadecimal,
    required this.pronosticoHoras,
    required this.pronosticoDias,
  });

  factory ClimaDTO.fromJson(Map<String, dynamic> json) {
    var listaHoras = json['pronosticoHoras'] as List? ?? [];
    var listaDias = json['pronosticoDias'] as List? ?? [];

    return ClimaDTO(
      ciudad: json['ciudad'] ?? 'Desconocido',
      pais: json['pais'] ?? '',
      temperatura: json['temperatura'] ?? 0,
      descripcion: json['descripcion'] ?? '',
      iconoUrl: json['iconoUrl'] ?? '',
      humidity: json['humidity'] ?? 0,
      viento: (json['viento'] as num?)?.toDouble() ?? 0.0,
      recomendacion: json['recomendacion'] ?? '',
      colorHexadecimal: json['colorHexadecimal'] ?? '#1E1E1E',
      pronosticoHoras: listaHoras.map((h) => HoraPronostico.fromJson(h)).toList(),
      pronosticoDias: listaDias.map((d) => DiaPronostico.fromJson(d)).toList(),
    );
  }
}

class HoraPronostico {
  final String hora;
  final int temp;
  final String iconoUrl;

  HoraPronostico({required this.hora, required this.temp, required this.iconoUrl});

  factory HoraPronostico.fromJson(Map<String, dynamic> json) {
    return HoraPronostico(
      hora: json['hora'] ?? '',
      temp: json['temp'] ?? 0,
      iconoUrl: json['iconoUrl'] ?? '',
    );
  }
}

class DiaPronostico {
  final String dia;
  final int tempMax;
  final String iconoUrl;

  DiaPronostico({required this.dia, required this.tempMax, required this.iconoUrl});

  factory DiaPronostico.fromJson(Map<String, dynamic> json) {
    return DiaPronostico(
      dia: json['dia'] ?? '',
      tempMax: json['tempMax'] ?? 0,
      iconoUrl: json['iconoUrl'] ?? '',
    );
  }
}