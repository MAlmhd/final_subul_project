import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/shipment_in_process_entity/shipment_in_process_entity.dart';

abstract class GetShipmentsInProcessRepo {
  Future<Either<Failure, List<ShipmentInProcessEntity>>> getShipments();
}
