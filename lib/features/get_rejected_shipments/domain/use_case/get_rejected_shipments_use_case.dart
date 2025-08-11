import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_rejected_shipments/domain/entities/rejected_shipment_entity.dart';
import 'package:final_subul_project/features/get_rejected_shipments/domain/repos/get_rejected_shipments_repo.dart';

class GetRejectedShipmentsUseCase
    extends UseCase<List<RejectedShipmentEntity>, NoParam> {
  final GetRejectedShipmentsRepo getRejectedShipmentsRepo;

  GetRejectedShipmentsUseCase(this.getRejectedShipmentsRepo);
  @override
  Future<Either<Failure, List<RejectedShipmentEntity>>> call([
    NoParam? params,
  ]) async {
    return getRejectedShipmentsRepo.getRejectedShipments();
  }
}
