import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/create_shipment/data/data_source/create_shipment_data_source/create_shipment_remote_data_source.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/create_shipment_entity/create_shipment_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/repos/create_shipment_repo/create_shipment_repo.dart';
import 'package:image_picker/image_picker.dart';

class CreateShipmentRepoImpl implements CreateShipmentRepo {
  final CreateShipmentRemoteDataSource createShipmentRemoteDataSource;

  CreateShipmentRepoImpl(this.createShipmentRemoteDataSource);
  @override
  Future<Either<Failure, CreateShipmentEntity>> createShipment({
    required String type,
    required int customerId,
    required List<int> supplierIds,
    required String declaredParcelsCount,
    required String notes,
    required int originCountryId,
    required int destenationCountryId,
    required XFile invoiceFile,
  }) async {
    try {
      var data = await createShipmentRemoteDataSource.createShipment(
        type: type,
        customerId: customerId,
        supplierIds: supplierIds,
        declaredParcelsCount: declaredParcelsCount,
        notes: notes,
        originCountryId: originCountryId,
        destenationCountryId: destenationCountryId, invoiceFile: invoiceFile,
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
