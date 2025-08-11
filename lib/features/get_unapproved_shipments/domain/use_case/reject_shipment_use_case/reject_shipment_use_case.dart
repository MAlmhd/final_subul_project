import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/entities/response_of_reject_shipment_entity/response_of_reject_shipment_entity.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/repos/reject_shipment_repo/reject_shipment_repo.dart';

class RejectShipmentUseCase
    extends UseCase<ResponseOfRejectShipmentEntity, RejectShipmentParam> {
  final RejectShipmentRepo rejectShipmentRepo;

  RejectShipmentUseCase(this.rejectShipmentRepo);

  @override
  Future<Either<Failure, ResponseOfRejectShipmentEntity>> call([
    RejectShipmentParam? params,
  ]) async {
    return await rejectShipmentRepo.reject(
      id: params!.id,
      reason: params.reason,
    );
  }
}

class RejectShipmentParam {
  final int id;
  final String reason;

  RejectShipmentParam({required this.id, required this.reason});
}
