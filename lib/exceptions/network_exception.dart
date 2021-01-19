class NetworkException implements Exception {
  final String _message;

  NetworkException([this._message = '']);

  String toString() => _message;
}

class FetchDataException extends NetworkException {
  FetchDataException([
    String _message = '',
  ]) : super("Error occured while connecting to the server: " + _message);
}

class BadRequestException extends NetworkException {
  BadRequestException([
    String _message = '',
  ]) : super("Invalid request: " + _message);
}

class UnauthorisedException extends NetworkException {
  UnauthorisedException([
    String _message = '',
  ]) : super("Unauthorised access: " + _message);
}

class InvalidInputException extends NetworkException {
  InvalidInputException([
    String _message = '',
  ]) : super("Invalid input: " + _message);
}
