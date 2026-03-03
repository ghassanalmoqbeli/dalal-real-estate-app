import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase2<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}
