import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/get_shipment_details_data_source/get_shipment_details_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/get_shipment_details_entity/get_shipment_details_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_shipment_details_repo/get_shipment_details_repo.dart';

class GetShipmentDetailsRepoImpl implements GetShipmentDetailsRepo {
  final GetShipmentDetailsRemoteDataSource getShipmentDetailsRemoteDataSource;

  GetShipmentDetailsRepoImpl(this.getShipmentDetailsRemoteDataSource);
  @override
  Future<Either<Failure, GetShipmentDetailsEntity>> getShipmentDetails({
    required int shipmentId,
  }) async {
    try {
      var data = await getShipmentDetailsRemoteDataSource.getShipments(
        idShipment: shipmentId,
      );
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
