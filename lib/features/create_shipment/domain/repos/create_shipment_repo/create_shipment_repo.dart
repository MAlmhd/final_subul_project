import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/create_shipment_entity/create_shipment_entity.dart';

abstract class CreateShipmentRepo {
  Future<Either<Failure, CreateShipmentEntity>> createShipment({
    required String type,
    required int customerId,
    required int supplierId,
    required String declaredParcelsCount,
    required String notes,
    required int originCountryId,
    required int destenationCountryId,
  });
}
