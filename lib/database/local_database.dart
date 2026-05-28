import '../models/weather_model.dart';
import '../models/usuario_model.dart';

class LocalDatabase {
  static UsuarioModel? usuarioLogueado;

  static List<WeatherModel> listaCiudadesTotal = [
    WeatherModel(
      ciudad: 'Orizaba',
      pais: 'Veracruz, MX',
      temperatura: 22.0,
      humidity: 68,
      descripcion: 'Nubes dispersas',
      iconoUrl: 'https://openweathermap.org/img/wn/03d@4x.png',
      condition: 'clouds',
      recomendacion: 'El clima está templado en Orizaba. Un suéter ligero será suficiente para tus actividades.',
      pronosticoHoras: [
        HourlyForecast(hora: '09:00', temperatura: 19.0, iconoUrl: 'https://openweathermap.org/img/wn/03d.png'),
        HourlyForecast(hora: '12:00', temperatura: 22.0, iconoUrl: 'https://openweathermap.org/img/wn/03d.png'),
        HourlyForecast(hora: '15:00', temperatura: 24.0, iconoUrl: 'https://openweathermap.org/img/wn/04d.png'),
        HourlyForecast(hora: '18:00', temperatura: 21.0, iconoUrl: 'https://openweathermap.org/img/wn/04d.png'),
        HourlyForecast(hora: '21:00', temperatura: 18.0, iconoUrl: 'https://openweathermap.org/img/wn/04n.png'),
      ],
      pronosticoDias: [
        DailyForecast(dia: 'Jueves', temperaturaMax: 24.0, temperaturaMin: 15.0, descripcion: 'Lluvia', iconoUrl: 'https://openweathermap.org/img/wn/10d.png'),
        DailyForecast(dia: 'Viernes', temperaturaMax: 25.0, temperaturaMin: 16.0, descripcion: 'Despejado', iconoUrl: 'https://openweathermap.org/img/wn/01d.png'),
        DailyForecast(dia: 'Sábado', temperaturaMax: 22.0, temperaturaMin: 14.0, descripcion: 'Nublado', iconoUrl: 'https://openweathermap.org/img/wn/03d.png'),
        DailyForecast(dia: 'Domingo', temperaturaMax: 26.0, temperaturaMin: 17.0, descripcion: 'Despejado', iconoUrl: 'https://openweathermap.org/img/wn/01d.png'),
      ],
    ),
    WeatherModel(
      ciudad: 'Madrid',
      pais: 'Spain',
      temperatura: 24.0,
      humidity: 71,
      descripcion: 'Tormenta Eléctrica',
      iconoUrl: 'https://openweathermap.org/img/wn/11d@4x.png',
      condition: 'thunderstorm',
      recomendacion: 'Lleva paraguas o impermeable indispensable. Conduce con precaución extra.',
      pronosticoHoras: [
        HourlyForecast(hora: '10:00', temperatura: 22.0, iconoUrl: 'https://openweathermap.org/img/wn/04d.png'),
        HourlyForecast(hora: '13:00', temperatura: 24.0, iconoUrl: 'https://openweathermap.org/img/wn/11d.png'),
        HourlyForecast(hora: '16:00', temperatura: 23.0, iconoUrl: 'https://openweathermap.org/img/wn/11d.png'),
        HourlyForecast(hora: '19:00', temperatura: 20.0, iconoUrl: 'https://openweathermap.org/img/wn/09d.png'),
        HourlyForecast(hora: '22:00', temperatura: 17.0, iconoUrl: 'https://openweathermap.org/img/wn/11n.png'),
      ],
      pronosticoDias: [
        DailyForecast(dia: 'Jueves', temperaturaMax: 22.0, temperaturaMin: 13.0, descripcion: 'Tormenta', iconoUrl: 'https://openweathermap.org/img/wn/11d.png'),
        DailyForecast(dia: 'Viernes', temperaturaMax: 21.0, temperaturaMin: 12.0, descripcion: 'Lluvia', iconoUrl: 'https://openweathermap.org/img/wn/10d.png'),
        DailyForecast(dia: 'Sábado', temperaturaMax: 24.0, temperaturaMin: 14.0, descripcion: 'Despejado', iconoUrl: 'https://openweathermap.org/img/wn/01d.png'),
        DailyForecast(dia: 'Domingo', temperaturaMax: 26.0, temperaturaMin: 16.0, descripcion: 'Despejado', iconoUrl: 'https://openweathermap.org/img/wn/01d.png'),
      ],
    ),
    WeatherModel(
      ciudad: 'Paris',
      pais: 'France',
      temperatura: 18.0,
      humidity: 85,
      descripcion: 'Lluvia ligera',
      iconoUrl: 'https://openweathermap.org/img/wn/10d@4x.png',
      condition: 'rain',
      recomendacion: 'Previsión de lluvias constantes. Te recomendamos visitar lugares techados.',
      pronosticoHoras: [
        HourlyForecast(hora: '08:00', temperatura: 16.0, iconoUrl: 'https://openweathermap.org/img/wn/09d.png'),
        HourlyForecast(hora: '11:00', temperatura: 18.0, iconoUrl: 'https://openweathermap.org/img/wn/10d.png'),
        HourlyForecast(hora: '14:00', temperatura: 19.0, iconoUrl: 'https://openweathermap.org/img/wn/10d.png'),
        HourlyForecast(hora: '17:00', temperatura: 17.0, iconoUrl: 'https://openweathermap.org/img/wn/09d.png'),
        HourlyForecast(hora: '20:00', temperatura: 15.0, iconoUrl: 'https://openweathermap.org/img/wn/10n.png'),
      ],
      pronosticoDias: [
        DailyForecast(dia: 'Jueves', temperaturaMax: 19.0, temperaturaMin: 11.0, descripcion: 'Lluvia', iconoUrl: 'https://openweathermap.org/img/wn/10d.png'),
        DailyForecast(dia: 'Viernes', temperaturaMax: 17.0, temperaturaMin: 10.0, descripcion: 'Chubascos', iconoUrl: 'https://openweathermap.org/img/wn/09d.png'),
        DailyForecast(dia: 'Sábado', temperaturaMax: 18.0, temperaturaMin: 11.0, descripcion: 'Nublado', iconoUrl: 'https://openweathermap.org/img/wn/03d.png'),
        DailyForecast(dia: 'Domingo', temperaturaMax: 20.0, temperaturaMin: 12.0, descripcion: 'Despejado', iconoUrl: 'https://openweathermap.org/img/wn/01d.png'),
      ],
    ),
    WeatherModel(
      ciudad: 'Monterrey',
      pais: 'Nuevo León, MX',
      temperatura: 34.0,
      humidity: 40,
      descripcion: 'Cielo despejado',
      iconoUrl: 'https://openweathermap.org/img/wn/01d@4x.png',
      condition: 'clear',
      recomendacion: 'Altas temperaturas en Monterrey. Usa protector solar y evita la exposición al sol.',
      pronosticoHoras: [
        HourlyForecast(hora: '09:00', temperatura: 28.0, iconoUrl: 'https://openweathermap.org/img/wn/01d.png'),
        HourlyForecast(hora: '12:00', temperatura: 32.0, iconoUrl: 'https://openweathermap.org/img/wn/01d.png'),
        HourlyForecast(hora: '15:00', temperatura: 34.0, iconoUrl: 'https://openweathermap.org/img/wn/01d.png'),
        HourlyForecast(hora: '18:00', temperatura: 33.0, iconoUrl: 'https://openweathermap.org/img/wn/01d.png'),
        HourlyForecast(hora: '21:00', temperatura: 29.0, iconoUrl: 'https://openweathermap.org/img/wn/01n.png'),
      ],
      pronosticoDias: [
        DailyForecast(dia: 'Jueves', temperaturaMax: 35.0, temperaturaMin: 22.0, descripcion: 'Despejado', iconoUrl: 'https://openweathermap.org/img/wn/01d.png'),
        DailyForecast(dia: 'Viernes', temperaturaMax: 36.0, temperaturaMin: 23.0, descripcion: 'Despejado', iconoUrl: 'https://openweathermap.org/img/wn/01d.png'),
        DailyForecast(dia: 'Sábado', temperaturaMax: 33.0, temperaturaMin: 21.0, descripcion: 'Viento', iconoUrl: 'https://openweathermap.org/img/wn/50d.png'),
        DailyForecast(dia: 'Domingo', temperaturaMax: 34.0, temperaturaMin: 22.0, descripcion: 'Nublado', iconoUrl: 'https://openweathermap.org/img/wn/03d.png'),
      ],
    ),
  ];

  static List<WeatherModel> listaFavoritos = [];
}
