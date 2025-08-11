import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/create_shipment/data/data_source/create_shipment_data_source/create_shipment_remote_data_source.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/response_of_create_shipment_entity/response_of_create_shipment_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/repos/create_shipment_repo/create_shipment_repo.dart';

class CreateShipmentRepoImpl implements CreateShipmentRepo {
  final CreateShipmentRemoteDataSource createShipmentRemoteDataSource;

  CreateShipmentRepoImpl(this.createShipmentRemoteDataSource);
  @override
  Future<Either<Failure, ResponseOfCreateShipmentEntity>> createShipment({
    required String type,
    required int customerId,
    required String supplierName,
    required String supplierNumber,
    required String declaredParcelsCount,
    required String notes,
    required int originCountryId,
    required int destenationCountryId,
  }) async {
    try {
      var data = await createShipmentRemoteDataSource.createShipment(
        type: type,
        customerId: customerId,
        supplierName: supplierName,
        supplierNumber: supplierNumber,
        declaredParcelsCount: declaredParcelsCount,
        notes: notes,
        originCountryId: originCountryId,
        destenationCountryId: destenationCountryId,
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
