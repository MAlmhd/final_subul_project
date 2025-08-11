import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/get_shipment_details_entity/get_shipment_details_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_shipment_details_repo/get_shipment_details_repo.dart';

class GetShipmentDetailsUseCase extends UseCase<GetShipmentDetailsEntity, int> {
  final GetShipmentDetailsRepo getShipmentDetailsRepo;

  GetShipmentDetailsUseCase(this.getShipmentDetailsRepo);
  @override
  Future<Either<Failure, GetShipmentDetailsEntity>> call([int? params]) async {
    return await getShipmentDetailsRepo.getShipmentDetails(shipmentId: params!);
  }
}
