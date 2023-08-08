
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_test_app/data/datasource/weather_remote_data_source.dart';
import 'package:weather_test_app/data/repositories/weather_repo_impl.dart';
import 'package:weather_test_app/domain/repositories/weather_repo.dart';
import 'package:weather_test_app/domain/services/location_service.dart';
import 'package:weather_test_app/domain/services/permissions_service.dart';
import 'package:weather_test_app/domain/services/weather_service.dart';
import 'package:weather_test_app/presentation/bloc/weather_bloc/weather_bloc.dart';

import 'data/datasource/weather_local_data_source.dart';

final locator = GetIt.instance;

void init(){
  //bloc
  locator.registerFactory(() => WeatherBloc(locator(), locator(), locator()));

  //data sources
  locator.registerLazySingleton<WeatherRemoteDataSource>(
        () => WeatherRemoteDataSourceImplementation(Dio()),
  );
  locator.registerLazySingleton<WeatherLocalDataSource>(
          () => WeatherLocalDataSourceImplementation(),
  );

  //repository
  locator.registerLazySingleton<WeatherRepository>(
          () => WeatherRepositoryImplementation(remoteDataSource: locator(), localDataSource: locator()));

  // services
  locator.registerLazySingleton(() => WeatherService(repository: locator()));
  locator.registerLazySingleton<LocationService>(() => LocationServiceImplementation(permissionService: locator()));
  locator.registerLazySingleton<PermissionService>(() => PermissionServiceImplementation());
}