import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_rejected_shipments/domain/entities/rejected_shipment_entity.dart';

abstract class GetRejectedShipmentsRepo {
  Future<Either<Failure, List<RejectedShipmentEntity>>> getRejectedShipments();
}
