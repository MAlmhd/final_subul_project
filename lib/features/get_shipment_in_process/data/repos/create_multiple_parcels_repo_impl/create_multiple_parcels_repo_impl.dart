import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/helpers/create_parcels_request.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/create_multiple_parcels_data_source/create_multiple_parcels_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_multiple_parcels_entity/create_multiple_parcels_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/create_multiple_parcels_repo/create_multiple_parcels_repo.dart';

class CreateMultipleParcelsRepoImpl extends CreateMultipleParcelsRepo {
  final CreateMultipleParcelsRemoteDataSource
  createMultipleParcelsRemoteDataSource;

  CreateMultipleParcelsRepoImpl(this.createMultipleParcelsRemoteDataSource);
  @override
  Future<Either<Failure, CreateMultipleParcelsEntity>> createMultipleParcels({
    required int shipmentId,
    required List<ParcelRequest> parcels,
  }) async {
    try {
      var data = await createMultipleParcelsRemoteDataSource
          .createMultipleParcels(shipmentId: shipmentId, items: parcels);
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
