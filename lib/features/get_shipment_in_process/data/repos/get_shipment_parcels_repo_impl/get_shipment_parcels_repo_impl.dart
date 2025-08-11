import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/get_shipment_parcels_data_source/get_shipment_parcels_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/specific_parcels_of_shipment_entity/specific_parcels_of_shipment_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_shipment_parcels_repo/get_shipment_parcels_repo.dart';

class GetShipmentParcelsRepoImpl extends GetShipmentParcelsRepo {
  final GetShipmentParcelsRemoteDataSource getShipmentParcelsRemoteDataSource;

  GetShipmentParcelsRepoImpl(this.getShipmentParcelsRemoteDataSource);
  @override
  Future<Either<Failure, List<SpecificParcelsOfShipmentEntity>>>
  getShipmentParcels({required int shipmentId}) async {
    try {
      var data = await getShipmentParcelsRemoteDataSource.getShipmentParcels(
        shipmentId: shipmentId,
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
