import '../../../domain/models/forecast_view_model.dart';

sealed class WeatherState{
  const WeatherState();
}

class WeatherLoading extends WeatherState{

}

class WeatherError extends WeatherState{
  final String message;
  WeatherError({required this.message});
}

class WeatherData extends WeatherState{
  final ForecastViewModel data;
  WeatherData({required this.data});
}