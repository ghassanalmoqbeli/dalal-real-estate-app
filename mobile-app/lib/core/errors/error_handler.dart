import 'dart:async';
import 'dart:io';

import 'package:dallal_proj/core/errors/failure.dart';
import 'package:http/http.dart' as http;

Failure mapExceptionToFailure(Object e) {
  // if (e is ServerFailure) return ServerFailure(e.message);
  // if (e is NetworkFailure) return NetworkFailure(e.message);
  // if (e is ParsingFailure) return ParsingFailure(e.message);
  if (e is SocketException) {
    return NetworkFailure('No internet connection::: MyErrorMsg: ${e.message}');
  } else if (e is TimeoutException) {
    return NetworkFailure('Request timeout::: MyErrorMsg: ${e.message}');
  } else if (e is http.Response) {
    return ServerFailure(
      'Server error: ${e.statusCode} . MSG: ::: MyErrorMsg: ${e.body}',
    );
  } else if (e is FormatException) {
    return ParsingFailure('Data format error::: MyErrorMsg: ${e.message}');
  }
  return UnknownFailure("Unexpected error: $e");
}
