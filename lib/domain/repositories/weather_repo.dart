import 'package:dartz/dartz.dart';

import '../../utils/models/failure.dart';
import '../models/forecast_view_model.dart';

abstract interface class WeatherRepository{
  Future<Either<Failure, ForecastViewModel>> getForecastByLocation ({required double lat, required double long});
}