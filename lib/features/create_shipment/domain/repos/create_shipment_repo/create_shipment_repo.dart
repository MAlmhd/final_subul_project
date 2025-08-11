import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/response_of_create_shipment_entity/response_of_create_shipment_entity.dart';

abstract class CreateShipmentRepo {
  Future<Either<Failure, ResponseOfCreateShipmentEntity>> createShipment({
    required String type,
    required int customerId,
    required String supplierName,
    required String supplierNumber,
    required String declaredParcelsCount,
    required String notes,
    required int originCountryId,
    required int destenationCountryId,
  });
}
