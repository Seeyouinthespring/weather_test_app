import '../../data/models/forecast_data_model.dart';
import '../../data/models/weather_info_section_data_model.dart';
import '../../domain/models/forecast_view_model.dart';
import 'exceptions.dart';

extension StringExtension on String {
  String get capitalize => "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
}

extension ForecastDataModelExtension on ForecastDataModel{
  ForecastViewModel toViewModel(bool takeFirst) {
    int current = takeFirst ? 0 : _getCurrentDataIndex(list) - 1;
    return ForecastViewModel(
      location: "${city.name} ${city.country}",
      currentWeatherDescription: list[current].weather.main,
      currentWeatherDescriptionDetailed: list[current].weather.description,
      currentT: list[current].main.t.toInt(),
      maxT: list[current].main.tMax.ceil(),
      minT: list[current].main.tMin.floor(),
      windSpeed: list[current].wind.speed,
      windDirection: _getWindDirection(list[current].wind.degree),
      humidity: list[current].main.humidity.toInt(),
      humidityDescription: _getHumidityDescription(list.first.main.humidity),
      comingHours: list.skip(current + 1).take(4).map((e) => ComingHour(
        dateTime: DateTime.parse(e.dateTime),
        t: e.main.t.toInt(),
        weatherDescription: e.weather.main,
      )).toList(),
      currentDate: DateTime.parse(list[current].dateTime),
      selected: DateTime.parse(list[current].dateTime),
    );
  }

  int _getCurrentDataIndex(List<WeatherInfoSectionDataModel> list){
    DateTime currentDate = DateTime.now();
    int index = -1;
    for (int i = 0; i < list.length; i++){
      if (DateTime.parse(list[i].dateTime).isAfter(currentDate)){
        index = i;
        break;
      }
    }
    if (index == -1) {
      throw const CacheException( message: "No cached data for current date",);
    }
    return index == -1 ? list.length - 1 : index;
  }
  
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