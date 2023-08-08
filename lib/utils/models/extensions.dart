import '../../data/models/forecast_data_model.dart';
import '../../domain/models/forecast_view_model.dart';

extension StringExtension on String {
  String get capitalize => "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
}

extension ForecastDataModelExtension on ForecastDataModel{
  ForecastViewModel get toViewModel => ForecastViewModel(
    location: "${city.name} ${city.country}",
    currentWeatherDescription: list.first.weather.main,
    currentWeatherDescriptionDetailed: list.first.weather.description,
    currentT: list.first.main.t.toInt(),
    maxT: list.first.main.tMax.ceil(),
    minT: list.first.main.tMin.floor(),
    windSpeed: list.first.wind.speed,
    windDirection: _getWindDirection(list.first.wind.degree),
    humidity: list.first.main.humidity.toInt(),
    humidityDescription: _getHumidityDescription(list.first.main.humidity),
    comingHours: list.skip(1).take(4).map((e) => ComingHour(
      dateTime: DateTime.parse(e.dateTime),
      t: e.main.t.toInt(),
      weatherDescription: e.weather.main,
    )).toList(),
    currentDate: DateTime.parse(list.first.dateTime),
    selected: DateTime.parse(list.first.dateTime),
  );

  String _getWindDirection(int deg) => switch (deg) {
  < 24 => "Северный",
  < 69 => "Северо-восточный",
  < 144 => "Восточный",
  < 159 => "Юго-восточный",
  < 204 => "Южный",
  < 249 => "Юго-западный",
  < 294 => "Западный",
  < 339 => "Северо-западный",
  _ => 'Северный.',
  };

  String _getHumidityDescription(int humidity) => switch (humidity) {
  < 25 => "Низкая",
  < 40 => "Пониженная",
  < 70 => "Средняя",
  < 85 => "Повышенная",
  _ => "Высокая"
  };
}