import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/entities/response_of_reject_shipment_entity/response_of_reject_shipment_entity.dart';

abstract class RejectShipmentRepo {
  Future<Either<Failure, ResponseOfRejectShipmentEntity>> reject({
    required int id,
    required String reason,
  });
}
