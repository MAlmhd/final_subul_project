import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/show_companies_and_clients/domain/entities/delete_user_entity/delete_user_entity.dart';
import 'package:final_subul_project/features/show_companies_and_clients/domain/repos/delete_user_repo/delete_user_repo.dart';

class DeleteUserUseCase extends UseCase<DeleteUserEntity, int> {
  final DeleteUserRepo deleteUserRepo;

  DeleteUserUseCase(this.deleteUserRepo);
  @override
  Future<Either<Failure, DeleteUserEntity>> call([int? id]) async {
    return await deleteUserRepo.delete(id: id!);
  }
}
