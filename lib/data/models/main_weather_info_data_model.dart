import 'package:hive/hive.dart';

part 'main_weather_info_data_model.g.dart';

@HiveType(typeId: 6)
class MainWeatherInfoDataModel{

  @HiveField(0)
  final double t;

  @HiveField(1)
  final double tMax;

  @HiveField(2)
  final double tMin;

  @HiveField(3)
  final int humidity;

  MainWeatherInfoDataModel({required this.t, required this.tMax, required this.tMin, required this.humidity});

  factory MainWeatherInfoDataModel.fromJson(Map<String, dynamic> json) => MainWeatherInfoDataModel(
    humidity: json['humidity'],
    t: double.parse(json['temp'].toString()),
    tMax: double.parse(json['temp_max'].toString()),
    tMin: double.parse(json['temp_min'].toString()),
  );
}