import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/entities/response_of_approve_shipment_entity/response_of_approve_shipment_entity.dart';

abstract class ApproveShipmentRepo {
  Future<Either<Failure, ResponseOfApproveShipmentEntity>> approve({
    required int id,
  });
}
