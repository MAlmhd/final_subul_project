import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/get_deliverable_shipments_entity/get_deliverable_shipments_entity.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/repos/get_deliverable_shipments_repo/get_deliverable_shipments_repo.dart';

class GetDeliverableShipmentsUseCase
    extends UseCase<List<GetDeliverableShipmentsEntity>, NoParam> {
  final GetDeliverableShipmentsRepo getDeliverableShipmentsRepo;

  GetDeliverableShipmentsUseCase(this.getDeliverableShipmentsRepo);
  @override
  Future<Either<Failure, List<GetDeliverableShipmentsEntity>>> call([
    NoParam? params,
  ]) async {
    return await getDeliverableShipmentsRepo.getDeliverableShipments();
  }
}
