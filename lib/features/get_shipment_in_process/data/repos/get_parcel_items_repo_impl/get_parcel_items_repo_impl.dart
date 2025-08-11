import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/get_parcel_items_data_source/get_parcel_items_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/get_parcel_items_entity/get_parcel_items_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_parcel_items_repo/get_parcel_items_repo.dart';

class GetParcelItemsRepoImpl implements GetParcelItemsRepo {
  final GetParcelItemsRemoteDataSource getParcelItemsRemoteDataSource;

  GetParcelItemsRepoImpl(this.getParcelItemsRemoteDataSource);
  @override
  Future<Either<Failure, List<GetParcelItemsEntity>>> getParcelItems({
    required int id,
  }) async {
    try {
      var data = await getParcelItemsRemoteDataSource.getParcelItems(id: id);
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
