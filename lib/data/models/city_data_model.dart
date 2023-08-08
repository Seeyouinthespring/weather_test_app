import 'package:hive/hive.dart';
import 'package:weather_test_app/data/models/coordinates_data_model.dart';

part 'city_data_model.g.dart';

@HiveType(typeId: 1)
class CityDataModel{

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String country;

  @HiveField(3)
  final CoordinatesDataModel coordinates;

  CityDataModel({required this.id, required this.name, required this.country, required this.coordinates});

  factory CityDataModel.fromJson(Map<String, dynamic> json) => CityDataModel(
    id: json['id'],
    name: json['name'],
    coordinates: CoordinatesDataModel.fromJson(json['coord']),
    country: json['country'],
  );

  factory CityDataModel.placeholder() => CityDataModel(
      id: -1,
      name: '',
      country: '',
      coordinates: CoordinatesDataModel.placeholder(),
  );

   Map<String, dynamic> toJson() => {
     'id': id,
     'name': name,
     'country': country,
     'coord': coordinates.toJson(),
   };
}