import 'package:hive/hive.dart';

part 'weather_description_data_model.g.dart';

@HiveType(typeId: 5)
class WeatherDescriptionDataModel{

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String main;

  WeatherDescriptionDataModel({required this.id, required this.description, required this.main});

  factory WeatherDescriptionDataModel.fromJson(Map<String, dynamic> json) => WeatherDescriptionDataModel(
    id: json['id'],
    description: json['description'],
    main: json['main'],
  );
}