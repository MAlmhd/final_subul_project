import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/user_entity/user_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/repos/get_users_repo/get_users_repo.dart';

class GetUserUseCase extends UseCase<List<UserEntity>, NoParam> {
  final GetUsersRepo getUsersRepo;

  GetUserUseCase(this.getUsersRepo);
  @override
  Future<Either<Failure, List<UserEntity>>> call([NoParam? params]) async {
    return await getUsersRepo.getUsers();
  }
}
