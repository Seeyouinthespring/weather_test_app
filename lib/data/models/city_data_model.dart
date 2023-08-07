import 'package:weather_test_app/data/models/coordinates_data_model.dart';

class CityDataModel{
  final int id;
  final String name;
  final String country;
  final CoordinatesDataModel coordinates;

  CityDataModel({required this.id, required this.name, required this.country, required this.coordinates});

  factory CityDataModel.fromJson(Map<String, dynamic> json) => CityDataModel(
    id: json['id'],
    name: json['name'],
    country: json['country'],
    coordinates: CoordinatesDataModel.fromJson(json['coord']),
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