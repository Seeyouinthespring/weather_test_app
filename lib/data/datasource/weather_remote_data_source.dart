import 'package:dio/dio.dart';
import 'package:weather_test_app/data/models/coordinates_data_model.dart';

import '../../utils/models/exceptions.dart';
import '../models/forecast_data_model.dart';

abstract interface class WeatherRemoteDataSource{
  Future<ForecastDataModel> getWeatherByLocation(CoordinatesDataModel coordinates);
}

class WeatherRemoteDataSourceImplementation implements WeatherRemoteDataSource{

  final Dio dio;
  static const _baseUrl = "https://api.openweathermap.org/data/2.5/forecast";
  WeatherRemoteDataSourceImplementation(this.dio);

  @override
  Future<ForecastDataModel> getWeatherByLocation(CoordinatesDataModel coordinates) async {
    try{
      final response = await dio.get(_baseUrl,
        queryParameters: {
          'lat': coordinates.lat,
          'lon': coordinates.long,
          'appid': '52b28e18f20e606ccf895332a455a161',
          'units': 'metric',
          'lang': 'ru'
        }
      );

      switch (response.statusCode!) {
        case 200:
          return ForecastDataModel.fromJson(response.data as Map <String, dynamic>);
        case 400:
          throw const ServerException(message: 'Bad Request');
        case 401:
          throw const ServerException(message: 'Unauthorized');
        case 403:
          throw const ServerException(message: 'Forbidden response');
        case 500:
          throw const ServerException(message: 'Error on server side');
        default:
          throw ServerException(message: 'Unknown error with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? "Dio Exception");
    } catch (e) {
      if (e is ServerException) rethrow;
      throw e.toString();
    }
  }
}
