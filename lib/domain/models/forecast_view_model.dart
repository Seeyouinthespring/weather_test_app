class ForecastViewModel {
  final String location;
  final String currentWeatherDescription; // TODO use enum
  final String currentWeatherDescriptionDetailed;
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
    required this.currentWeatherDescriptionDetailed,
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

  factory ForecastViewModel.placeholder() => ForecastViewModel(
        location: "",
        currentWeatherDescription: "",
        currentWeatherDescriptionDetailed: "",
        currentT: 0,
        maxT: 0,
        minT: 0,
        windSpeed: 0,
        windDirection: "",
        humidity: 0,
        humidityDescription: "",
        comingHours: [],
        currentDate: DateTime.now(),
        selected: DateTime.now(),
      );

  factory ForecastViewModel.copyWithSelected(ForecastViewModel model, {required DateTime selected}){
    return ForecastViewModel(
        location: model.location,
        currentWeatherDescription: model.currentWeatherDescription,
        currentWeatherDescriptionDetailed: model.currentWeatherDescriptionDetailed,
        currentT: model.currentT,
        maxT: model.maxT,
        minT: model.minT,
        windSpeed: model.windSpeed,
        windDirection: model.windDirection,
        humidity: model.humidity,
        humidityDescription: model.humidityDescription,
        comingHours: model.comingHours,
        currentDate: model.currentDate,
        selected: selected,
    );
  }
}

class ComingHour {
  final DateTime dateTime;
  final int t;
  final String weatherDescription; // TODO enum

  ComingHour(
      {required this.dateTime,
      required this.t,
      required this.weatherDescription});
}
