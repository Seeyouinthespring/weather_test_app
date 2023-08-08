import 'package:hive/hive.dart';

part 'wind_data_model.g.dart';

@HiveType(typeId: 4)
class WindDataModel{

  @HiveField(0)
  final double speed;

  @HiveField(1)
  final int degree;

  WindDataModel({required this.speed, required this.degree});

  factory WindDataModel.fromJson(Map<String, dynamic> json) {
    return WindDataModel(
      speed: double.parse(json['speed'].toString()),
      degree: json['deg'],
    );
  }
}