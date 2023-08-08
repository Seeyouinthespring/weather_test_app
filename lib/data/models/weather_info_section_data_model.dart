import 'package:hive/hive.dart';
import 'package:weather_test_app/data/models/weather_description_data_model.dart';
import 'package:weather_test_app/data/models/wind_data_model.dart';

import 'main_weather_info_data_model.dart';

part 'weather_info_section_data_model.g.dart';

@HiveType(typeId: 3)
class WeatherInfoSectionDataModel{

  @HiveField(0)
  final int ticks;

  @HiveField(1)
  final String dateTime;

  @HiveField(2)
  final WindDataModel wind;

  @HiveField(3)
  final WeatherDescriptionDataModel weather;

  @HiveField(4)
  final MainWeatherInfoDataModel main;

  WeatherInfoSectionDataModel({ required this.ticks, required this.dateTime, required this.wind, required this.weather, required this.main});

  factory WeatherInfoSectionDataModel.fromJson(Map<String, dynamic> json) => WeatherInfoSectionDataModel(
      ticks: json['dt'],
      dateTime: json['dt_txt'],
      wind: WindDataModel.fromJson(json['wind']),
      weather: WeatherDescriptionDataModel.fromJson(json['weather'][0]),
      main: MainWeatherInfoDataModel.fromJson(json['main']),
  );
}
