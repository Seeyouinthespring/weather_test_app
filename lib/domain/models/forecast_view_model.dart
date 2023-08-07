class ForecastViewModel{
  final String location;
  final String currentWeatherDescription; // TODO use enum
  final int currentT;
  final int maxT;
  final int minT;
  final double windSpeed;
  final String windDirection;
  final int humidity;
  final String humidityDescription; // TODO use enum
  final List<ComingHour> comingHours;
  final DateTime currentDate;
  final DateTime selected;

  ForecastViewModel({
    required this.location,
    required this.currentWeatherDescription,
    required this.currentT,
    required this.maxT,
    required this.minT,
    required this.windSpeed,
    required this.windDirection,
    required this.humidity,
    required this.humidityDescription,
    required this.comingHours,
    required this.currentDate,
    required this.selected,
  });
}


class ComingHour{
  final DateTime dateTime;
  final int t;
  final String weatherDescription; // TODO enum

  ComingHour({
    required this.dateTime,
    required this.t,
    required this.weatherDescription
  });
}