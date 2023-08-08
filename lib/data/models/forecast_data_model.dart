import 'package:hive/hive.dart';
import 'package:weather_test_app/data/models/city_data_model.dart';
import 'package:weather_test_app/data/models/weather_info_section_data_model.dart';

part 'forecast_data_model.g.dart';

@HiveType(typeId: 0)
class ForecastDataModel{

  @HiveField(0)
  final CityDataModel city;

  @HiveField(1)
  final List<WeatherInfoSectionDataModel> list;

  ForecastDataModel({required this.city, required this.list});

  factory ForecastDataModel.fromJson(Map<String, dynamic> json) {
    List<WeatherInfoSectionDataModel> weatherList = [];
    if (json['list'] != null) {
      List<dynamic> listJson = List<dynamic>.from(json['list']);
      for (var element in listJson) {
        weatherList.add(WeatherInfoSectionDataModel.fromJson(element));
      }
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

