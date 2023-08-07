import 'package:dio/dio.dart';
import 'package:weather_test_app/data/models/coordinates_data_model.dart';

import '../models/forecast_data_model.dart';

abstract interface class WeatherRemoteDataSource{
  Future<ForecastDataModel> getWeatherByLocation(CoordinatesDataModel coordinates);
}

class WeatherRemoteDataSourceImplementation implements WeatherRemoteDataSource{

  final Dio dio;
  static const _baseUrl = "api.openweathermap.org/data/2.5/forecast";
  WeatherRemoteDataSourceImplementation(this.dio);



  @override
  Future<ForecastDataModel> getWeatherByLocation(CoordinatesDataModel coordinates) async {

    try{
      final response = await dio.get(_baseUrl,
        queryParameters: {
          'lat': coordinates.lat,
          'long': coordinates.long,
          'appid': '52b28e18f20e606ccf895332a455a161',
        }
      );


      if (response.statusCode == 200){
        return ForecastDataModel.fromJson(response.data as Map <String, dynamic>);
      }
      return ForecastDataModel.placeholder();

    } catch (e) {
      print('ERROR type ---> ${e.runtimeType.toString()}');
      print('ERROR ---> ${e}');

      return ForecastDataModel.placeholder();
    }

  }

}