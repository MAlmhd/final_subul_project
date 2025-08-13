import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/specific_parcels_of_shipment_entity/specific_parcels_of_shipment_entity.dart';

abstract class GetShipmentParcelsRepo {
  Future<Either<Failure, SpecificParcelsOfShipmentEntity>>
  getShipmentParcels({required int shipmentId});
}
