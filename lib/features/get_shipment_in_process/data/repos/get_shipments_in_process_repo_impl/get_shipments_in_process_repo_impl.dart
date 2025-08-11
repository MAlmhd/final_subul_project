import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/get_shipments_in_process_data_source/get_shipment_in_process_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/shipment_in_process_entity/shipment_in_process_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_shipments_in_process_repo/get_shipments_in_process_repo.dart';

class GetShipmentsInProcessRepoImpl implements GetShipmentsInProcessRepo {
  final GetShipmentInProcessRemoteDataSource
  getShipmentInProcessRemoteDataSource;

  GetShipmentsInProcessRepoImpl(this.getShipmentInProcessRemoteDataSource);
  @override
  Future<Either<Failure, List<ShipmentInProcessEntity>>> getShipments() async {
    try {
      var data = await getShipmentInProcessRemoteDataSource.getShipments();
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
