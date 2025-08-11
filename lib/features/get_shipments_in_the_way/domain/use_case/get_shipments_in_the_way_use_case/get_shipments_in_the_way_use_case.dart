import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/shipment_in_the_way_entity/shipment_in_the_way_entity.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/repos/get_shipments_in_the_way_repo/get_shipments_in_the_way_repo.dart';

class GetShipmentsInTheWayUseCase
    extends UseCase<List<ShipmentInTheWayEntity>, NoParam> {
  final GetShipmentsInTheWayRepo getShipmentsInTheWayRepo;

  GetShipmentsInTheWayUseCase(this.getShipmentsInTheWayRepo);
  @override
  Future<Either<Failure, List<ShipmentInTheWayEntity>>> call([
    NoParam? params,
  ]) async {
    return await getShipmentsInTheWayRepo.getShipmentsInTheWay();
  }
}
