import 'dart:html';

import 'package:intl/intl.dart';
import 'package:weather_test_app/data/models/city_data_model.dart';
import 'package:weather_test_app/data/models/weather_info_section_data_model.dart';
import 'package:weather_test_app/domain/models/forecast_view_model.dart';

class ForecastDataModel{
  final CityDataModel city;
  final List<WeatherInfoSectionDataModel> list;

  ForecastDataModel({required this.city, required this.list});

  factory ForecastDataModel.fromJson(Map<String, dynamic> json) {
    List<WeatherInfoSectionDataModel> weatherList = [];
    if (json['list'] != null) {
      List<dynamic> listJson = json['list'];
      weatherList = listJson
          .map((jsonElement) => WeatherInfoSectionDataModel.fromJson(jsonElement))
          .toList();
    }

    return ForecastDataModel(
      city: CityDataModel.fromJson(json['city']),
      list: weatherList,
    );
  }

  factory ForecastDataModel.placeholder() => ForecastDataModel(
      city: CityDataModel.placeholder(),
      list: [],
  );
}

extension ForecastDataModelExtension on ForecastDataModel{
  ForecastViewModel get toViewModel => ForecastViewModel(
      location: "${city.name} ${city.country}",
      currentWeatherDescription: list.first.weather.main,
      currentT: list.first.main.t.toInt(),
      maxT: list.first.main.tMax.ceil(),
      minT: list.first.main.tMin.floor(),
      windSpeed: list.first.wind.speed,
      windDirection: list.first.wind.degree.toString(),
      humidity: list.first.main.humidity.toInt(),
      humidityDescription: list.first.main.humidity.toString(),
      comingHours: list.skip(1).take(4).map((e) => ComingHour(
          dateTime: DateTime.parse(e.dateTime),
          t: e.main.t.toInt(),
          weatherDescription: e.weather.main,
      )).toList(),
      currentDate: DateTime.parse(list.first.dateTime),
    selected: DateTime.parse(list.first.dateTime),
  );
}