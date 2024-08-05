class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() {
    return "Failure: $message";
  }
}

class ServerFailure extends Failure {
  final int? statusCode;

  ServerFailure(super.message, [this.statusCode]);

  @override
  String toString() {
    return "ServerFailure: $message (Status code: $statusCode)";
  }
}
