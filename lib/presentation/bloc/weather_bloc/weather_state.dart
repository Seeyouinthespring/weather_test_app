import '../../../domain/models/forecast_view_model.dart';

sealed class WeatherState{
  final ForecastViewModel data;
  const WeatherState({required this.data});
}

class WeatherLoading extends WeatherState{
  WeatherLoading({required super.data});
}

class WeatherError extends WeatherState{
  final String message;
  WeatherError({required this.message, required super.data});
}

class WeatherData extends WeatherState{
  WeatherData({required super.data});
}