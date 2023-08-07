import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_test_app/domain/services/permissions_service.dart';

import '../../utils/models/failure.dart';

abstract interface class LocationService{
 Future<Either<Failure, Position>> determineCurrentPosition();
}

class LocationServiceImplementation implements LocationService{

 final PermissionService permissionService; // = PermissionServiceImplementation();

 const LocationServiceImplementation({required this.permissionService});

  @override
  Future<Either<Failure, Position>> determineCurrentPosition() async {
   bool check = await permissionService.checkPermissions();
   if (check) {
     Position position = await Geolocator.getCurrentPosition();
     return Right(position);
   }
     return Left(DefaultFailure(message: 'No Permissions'));
  }
}

