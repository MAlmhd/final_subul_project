import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';

abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call([P params]);
}

class NoParam {}
