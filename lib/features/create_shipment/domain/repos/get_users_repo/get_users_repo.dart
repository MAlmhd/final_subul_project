import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/user_entity/user_entity.dart';

abstract class GetUsersRepo {
  Future<Either<Failure, List<UserEntity>>> getUsers();
}
