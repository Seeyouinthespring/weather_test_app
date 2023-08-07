import 'package:dartz/dartz.dart';
import 'package:weather_test_app/domain/models/forecast_view_model.dart';
import 'package:weather_test_app/domain/repositories/weather_repo.dart';

import '../../utils/models/failure.dart';

class WeatherService{
  final WeatherRepository repository;

  WeatherService({required this.repository});

  Future<Either<Failure, ForecastViewModel>> getData({required double lat, required double long}) async {
    return repository.getForecastByLocation(lat: lat, long: long);
  }
}