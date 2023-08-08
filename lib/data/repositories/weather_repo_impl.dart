import 'package:dartz/dartz.dart';
import 'package:weather_test_app/data/datasource/weather_remote_data_source.dart';
import 'package:weather_test_app/data/models/coordinates_data_model.dart';
import 'package:weather_test_app/data/models/forecast_data_model.dart';

import 'package:weather_test_app/domain/models/forecast_view_model.dart';
import 'package:weather_test_app/utils/models/extensions.dart';

import 'package:weather_test_app/utils/models/failure.dart';

import '../../domain/repositories/weather_repo.dart';

class WeatherRepositoryImplementation implements WeatherRepository{

  final WeatherRemoteDataSource dataSource;

  WeatherRepositoryImplementation({required this.dataSource});

  @override
  Future<Either<Failure, ForecastViewModel>> getForecastByLocation({required double lat, required double long}) async {
    try{
      ForecastDataModel forecastDataModel = await dataSource.getWeatherByLocation(CoordinatesDataModel(lat: lat, long: long));
      ForecastViewModel forecastViewModel = forecastDataModel.toViewModel;
      return Right(forecastViewModel);
    } catch (e){
      return Left(DefaultFailure(message: e.toString()));
    }

  }

}