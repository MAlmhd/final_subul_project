import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/data/data_source/get_deliverable_shipments_remote_data_source/get_deliverable_shipments_remote_data_source.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/get_deliverable_shipments_entity/get_deliverable_shipments_entity.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/repos/get_deliverable_shipments_repo/get_deliverable_shipments_repo.dart';

class GetDeliverableShipmentsRepoImpl implements GetDeliverableShipmentsRepo {
  final GetDeliverableShipmentsRemoteDataSource
  getDeliverableShipmentsRemoteDataSource;

  GetDeliverableShipmentsRepoImpl(this.getDeliverableShipmentsRemoteDataSource);
  @override
  Future<Either<Failure, List<GetDeliverableShipmentsEntity>>>
  getDeliverableShipments() async {
    try {
      var data =
          await getDeliverableShipmentsRemoteDataSource
              .getDeliverableShipments();
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
