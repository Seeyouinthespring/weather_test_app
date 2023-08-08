import 'package:hive/hive.dart';

part 'coordinates_data_model.g.dart';

@HiveType(typeId: 2)
class CoordinatesDataModel{

  @HiveField(0)
  final double lat;

  @HiveField(1)
  final double long;

  CoordinatesDataModel({required this.lat, required this.long});

  factory CoordinatesDataModel.fromJson(Map<String, dynamic> json) => CoordinatesDataModel(
    lat: json['lat'],
    long: json['lon'],
  );

  factory CoordinatesDataModel.placeholder() => CoordinatesDataModel(lat: 0.0, long: 0.0);

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lon': long,
  };
}