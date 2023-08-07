class WeatherInfoSectionDataModel{
  final int ticks;
  final String dateTime;
  final WindDataModel wind;
  final WeatherDescriptionDataModel weather;
  final MainWeatherInfoDataModel main;

  WeatherInfoSectionDataModel({ required this.ticks, required this.dateTime, required this.wind, required this.weather, required this.main});

  factory WeatherInfoSectionDataModel.fromJson(Map<String, dynamic> json) => WeatherInfoSectionDataModel(
      ticks: json['dt'],
      dateTime: json['dt_txt'],
      wind: WindDataModel.fromJson(json['wind']),
      weather: WeatherDescriptionDataModel.fromJson(json['weather']),
      main: MainWeatherInfoDataModel.fromJson(json['main']),
  );
}

class WindDataModel{
  final double speed;
  final int degree;

  WindDataModel({required this.speed, required this.degree});

  factory WindDataModel.fromJson(Map<String, dynamic> json) => WindDataModel(
    speed: json['speed'],
    degree: json['deg'],
  );
}

class WeatherDescriptionDataModel{
  final int id;
  final String description;
  final String main;

  WeatherDescriptionDataModel({required this.id, required this.description, required this.main});

  factory WeatherDescriptionDataModel.fromJson(Map<String, dynamic> json) => WeatherDescriptionDataModel(
    id: json['id'],
    description: json['description'],
    main: json['main'],
  );
}

class MainWeatherInfoDataModel{
  final double t;
  final double tMax;
  final double tMin;
  final double humidity;

  MainWeatherInfoDataModel({required this.t, required this.tMax, required this.tMin, required this.humidity});

  factory MainWeatherInfoDataModel.fromJson(Map<String, dynamic> json) => MainWeatherInfoDataModel(
      t: json['temp'],
      tMax: json['temp_min'],
      tMin: json['temp_max'],
      humidity: json['humidity'],
  );
}