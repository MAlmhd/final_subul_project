import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/update_shipments_warehouse_arrival_entity/update_shipments_warehouse_arrival_entity.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/repos/update_shipments_warehouse_arrival_repo/update_shipments_warehouse_arrival_repo.dart';

class UpdateShipmentsWarehouseArrivalUseCase
    extends
        UseCase<
          UpdateShipmentsWarehouseArrivalEntity,
          UpdateShipmentsWarehouseArrivalParams
        > {
  final UpdateShipmentsWarehouseArrivalRepo updateShipmentsWarehouseArrivalRepo;

  UpdateShipmentsWarehouseArrivalUseCase(
    this.updateShipmentsWarehouseArrivalRepo,
  );

  @override
  Future<Either<Failure, UpdateShipmentsWarehouseArrivalEntity>> call([
    UpdateShipmentsWarehouseArrivalParams? params,
  ]) async {
    return await updateShipmentsWarehouseArrivalRepo.updateShipment(
      id: params!.id,
      image: params.image,
    );
  }
}

class UpdateShipmentsWarehouseArrivalParams {
  final int id;
  final XFile image;

  UpdateShipmentsWarehouseArrivalParams({
    required this.id,
    required this.image,
  });
}
