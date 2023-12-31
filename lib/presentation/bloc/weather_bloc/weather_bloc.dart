import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_test_app/domain/models/forecast_view_model.dart';
import 'package:weather_test_app/presentation/bloc/weather_bloc/weather_event.dart';
import 'package:weather_test_app/presentation/bloc/weather_bloc/weather_state.dart';
import 'package:weather_test_app/utils/models/failure.dart';

import '../../../domain/services/location_service.dart';
import '../../../domain/services/permissions_service.dart';
import '../../../domain/services/weather_service.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;
  final LocationService locationService;
  final PermissionService permissionService;

  WeatherBloc(this.weatherService, this.locationService, this.permissionService)
      : super(WeatherLoading(data: ForecastViewModel.placeholder())) {
    on<OnInit>((event, emit) async {
      emit(WeatherLoading(data: ForecastViewModel.placeholder()));

      await permissionService.requestPermissions();

      final positionResult = await locationService.determineCurrentPosition();
      if (positionResult.isRight()) {
        Position position = positionResult.getOrElse(() => positionPlaceholder);
        final result = await weatherService.getData(
            lat: position.latitude, long: position.longitude);
        emit(result.fold(
            (l) => WeatherError(
                message: _getErrorMessage(l),
                data: ForecastViewModel.placeholder()),
            (r) => WeatherData(data: r)));
      } else {
        emit(
          WeatherError(
            message:
                positionResult.swap().getOrElse(() => DefaultFailure()).message,
            data: ForecastViewModel.placeholder(),
          ),
        );
      }
    });

    on<OnSelectSection>((event, emit) async {
      emit(
        WeatherData(
          data: ForecastViewModel.copyWithSelected(
            state.data,
            selected: event.selectedDateTime,
          ),
        ),
      );
    });
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case CacheFailure:
        return (failure as CacheFailure).message;
      case DefaultFailure:
        return (failure as DefaultFailure).message;
      default:
        return 'An unknown error has occured';
    }
  }

  Position get positionPlaceholder => Position(
        longitude: 0.0,
        latitude: 0.0,
        timestamp: DateTime.now(),
        accuracy: 0.1,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      );
}
