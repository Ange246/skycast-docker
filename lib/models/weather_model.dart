class HourlyForecast {
  final String hora;
  final double temperatura;
  final String iconoUrl;

  HourlyForecast({
    required this.hora,
    required this.temperatura,
    required this.iconoUrl,
  });
}

class DailyForecast {
  final String dia;
  final double temperaturaMax;
  final double temperaturaMin;
  final String descripcion;
  final String iconoUrl;

  DailyForecast({
    required this.dia,
    required this.temperaturaMax,
    required this.temperaturaMin,
    required this.descripcion,
    required this.iconoUrl,
  });
}

class WeatherModel {
  final String ciudad;
  final String pais;
  final double temperatura;
  final int humidity;
  final String descripcion;
  final String iconoUrl;
  final String recomendacion;
  final String condition;
  
  // Nuevos ArrayLists integrados al modelo de la ciudad
  final List<HourlyForecast> pronosticoHoras;
  final List<DailyForecast> pronosticoDias;

  WeatherModel({
    required this.ciudad,
    required this.pais,
    required this.temperatura,
    required this.humidity,
    required this.descripcion,
    required this.iconoUrl,
    required this.recomendacion,
    required this.condition,
    required this.pronosticoHoras,
    required this.pronosticoDias,
  });
}
