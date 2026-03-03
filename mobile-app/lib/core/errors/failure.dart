// class Failure {}

abstract class Failure implements Exception {
  final String message;
  const Failure(this.message);

  @override
  String toString() => toString();
}

class ServerFailure extends Failure {
  final dynamic error;
  const ServerFailure(super.message, {this.error});
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ParsingFailure extends Failure {
  const ParsingFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

// import 'dart:async';
// import 'dart:io';

// // import 'package:dartz/dartz.dart';
// import 'package:http/http.dart' as http;

// abstract class Failure implements Exception {
//   final String message;
//   final StackTrace? stackTrace;

//   const Failure(this.message, [this.stackTrace]);

//   @override
//   String toString() => message;
// }

// class ServerFailure extends Failure {
//   final int statusCode;

//   ServerFailure(String message, this.statusCode, [StackTrace? stackTrace])
//       : super(message, stackTrace);
// }

// class NetworkFailure extends Failure {
//   NetworkFailure(super.message, [super.stackTrace]);
// }

// class UnexpectedFailure extends Failure {
//   UnexpectedFailure(super.message, [super.stackTrace]);
// }
//   // UnexpectedFailure(String message, [StackTrace? stackTrace])
//   //     : super(message, stackTrace);

// // Step 2: Create error handler

// // error_handler.dart
// class ErrorHandler {
//   static Failure handleError(dynamic error) {
//     if (error is SocketException) {
//       return NetworkFailure('No internet connection');
//     } else if (error is TimeoutException) {
//       return NetworkFailure('Request timeout');
//     } else if (error is http.Response) {
//       return ServerFailure(
//         'Server error: ${error.statusCode}',
//         error.statusCode,
//       );
//     } else if (error is FormatException) {
//       return UnexpectedFailure('Data format error');
//     } else {
//       return UnexpectedFailure('Unexpected error: $error');
//     }
//   }
// }

//Step 3: Use in your API client

// class ApiClient {
//   final HttpService _http = HttpService();

//   Future<Either<Failure, User>> getUser(int id) async {
//     try {
//       final response = await _http.get('/users/$id');
//       final user = User.fromJson(jsonDecode(response.body));
//       return Right(user);
//     } catch (e, stackTrace) {
//       return Left(ErrorHandler.handleError(e));
//     }
//   }
// }
