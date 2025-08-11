import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/shipment_in_process_entity/shipment_in_process_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_shipments_in_process_repo/get_shipments_in_process_repo.dart';

class GetShipmentsInProcessUseCase
    extends UseCase<List<ShipmentInProcessEntity>, NoParam> {
  final GetShipmentsInProcessRepo getShipmentsInProcessRepo;

  GetShipmentsInProcessUseCase({required this.getShipmentsInProcessRepo});

  @override
  Future<Either<Failure, List<ShipmentInProcessEntity>>> call([
    NoParam? params,
  ]) async {
    return await getShipmentsInProcessRepo.getShipments();
  }
}
