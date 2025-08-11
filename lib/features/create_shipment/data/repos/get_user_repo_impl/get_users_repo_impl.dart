import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/create_shipment/data/data_source/get_users_data_source/get_users_remote_data_source.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/user_entity/user_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/repos/get_users_repo/get_users_repo.dart';

class GetUsersRepoImpl implements GetUsersRepo {
  final GetUsersRemoteDataSource getUsersRemoteDataSource;

  GetUsersRepoImpl(this.getUsersRemoteDataSource);
  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      var data = await getUsersRemoteDataSource.getUsers();
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
