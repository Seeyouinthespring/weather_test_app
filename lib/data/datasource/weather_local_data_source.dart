import 'package:weather_test_app/data/models/forecast_data_model.dart';
import 'package:hive/hive.dart';
import '../../utils/models/exceptions.dart';

abstract interface class WeatherLocalDataSource{
  Future<ForecastDataModel> getForecast();
  saveForecast(ForecastDataModel model);
}

class WeatherLocalDataSourceImplementation implements WeatherLocalDataSource{
  @override
  Future<ForecastDataModel> getForecast() async {
    try{
      final box = await Hive.openBox('forecast');
      ForecastDataModel forecast = box.getAt(0);
      return forecast;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  saveForecast(ForecastDataModel model) async {
    final box = await Hive.openBox('forecast');
    box.clear();
    box.add(model);
  }
  
}