import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/get_shipment_details_entity/get_shipment_details_entity.dart';

abstract class GetShipmentDetailsRepo {
  Future<Either<Failure, GetShipmentDetailsEntity>> getShipmentDetails({
    required int shipmentId,
  });
}
