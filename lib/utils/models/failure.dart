abstract class Failure{
  final String message;

  Failure({required this.message});
}

class DefaultFailure extends Failure{

  DefaultFailure({message}) : super(message: message);
}

class ServerFailure extends Failure {
  ServerFailure({message}) : super(message: message);
}

class CacheFailure extends Failure {
  CacheFailure({message}) : super(message: message);
}