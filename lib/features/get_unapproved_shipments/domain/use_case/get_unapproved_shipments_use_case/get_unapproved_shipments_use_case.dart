import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/entities/un_approved_shipment_entity/un_approved_shipments_entity.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/repos/get_unapproved_shipment_repo/get_unapproved_shipments_repo.dart';

class GetUnapprovedShipmentsUseCase
    extends UseCase<List<UnApprovedShipmentsEntity>, String?> {
  final GetUnapprovedShipmentsRepo getUnapprovedShipmentsRepo;

  GetUnapprovedShipmentsUseCase(this.getUnapprovedShipmentsRepo);

  @override
  Future<Either<Failure, List<UnApprovedShipmentsEntity>>> call([
    String? params,
  ]) async {
    return await getUnapprovedShipmentsRepo.getUnapprovedShipments();
  }
}
