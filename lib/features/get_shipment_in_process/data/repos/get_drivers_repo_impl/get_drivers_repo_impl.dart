import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/get_drivers_data_source/get_drivers_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/driver_entity/driver_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_drivers_repo/get_drivers_repo.dart';

class GetDriversRepoImpl implements GetDriversRepo {
  final GetDriversRemoteDataSource getDriversRemoteDataSource;

  GetDriversRepoImpl(this.getDriversRemoteDataSource);

  @override
  Future<Either<Failure, List<DriverEntity>>> getDrivers() async {
    try {
      var data = await getDriversRemoteDataSource.getDrivers();
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
