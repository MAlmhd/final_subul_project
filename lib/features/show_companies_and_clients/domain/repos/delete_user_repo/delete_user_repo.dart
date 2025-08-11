import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/show_companies_and_clients/domain/entities/delete_user_entity/delete_user_entity.dart';

abstract class DeleteUserRepo {
  Future<Either<Failure, DeleteUserEntity>> delete({required int id});
}
