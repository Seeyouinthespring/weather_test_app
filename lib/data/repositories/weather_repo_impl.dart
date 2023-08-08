import 'package:dartz/dartz.dart';
import 'package:weather_test_app/data/datasource/weather_remote_data_source.dart';
import 'package:weather_test_app/data/models/coordinates_data_model.dart';
import 'package:weather_test_app/data/models/forecast_data_model.dart';

import 'package:weather_test_app/domain/models/forecast_view_model.dart';
import 'package:weather_test_app/utils/models/exceptions.dart';
import 'package:weather_test_app/utils/models/extensions.dart';

import 'package:weather_test_app/utils/models/failure.dart';

import '../../domain/repositories/weather_repo.dart';
import '../datasource/weather_local_data_source.dart';

class WeatherRepositoryImplementation implements WeatherRepository{

  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;

  WeatherRepositoryImplementation({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, ForecastViewModel>> getForecastByLocation({required double lat, required double long}) async {
    try{
      ForecastDataModel forecastDataModel = await remoteDataSource.getWeatherByLocation(CoordinatesDataModel(lat: lat, long: long));
      await localDataSource.saveForecast(forecastDataModel);
      ForecastViewModel forecastViewModel = forecastDataModel.toViewModel(true);
      return Right(forecastViewModel);
    } on ServerException {
      try {
        final ForecastDataModel model = await localDataSource.getForecast();
        return Right(model.toViewModel(false));
      } on CacheException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}