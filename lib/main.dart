import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_test_app/data/models/city_data_model.dart';
import 'package:weather_test_app/data/models/coordinates_data_model.dart';
import 'package:weather_test_app/data/models/forecast_data_model.dart';
import 'package:weather_test_app/presentation/screens/splash_screen.dart';
import 'data/models/main_weather_info_data_model.dart';
import 'data/models/weather_description_data_model.dart';
import 'data/models/weather_info_section_data_model.dart';
import 'data/models/wind_data_model.dart';
import 'di.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDirectory.path)
    ..registerAdapter(ForecastDataModelAdapter())
    ..registerAdapter(CityDataModelAdapter())
    ..registerAdapter(CoordinatesDataModelAdapter())
    ..registerAdapter(WeatherInfoSectionDataModelAdapter())
    ..registerAdapter(WindDataModelAdapter())
    ..registerAdapter(WeatherDescriptionDataModelAdapter())
    ..registerAdapter(MainWeatherInfoDataModelAdapter());

  await Firebase.initializeApp();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          )
        )
      ),
      home: const SplashScreen(),
    );
  }
}
