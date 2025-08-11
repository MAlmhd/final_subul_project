import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_shipment_for_delivery_entity/update_shipment_for_delivery_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/update_shipment_for_delivery_repo/update_shipment_for_delivery_repo.dart';

class UpdateShipmentForDeliveryUseCase
    extends
        UseCase<
          UpdateShipmentForDeliveryEntity,
          UpdateShipmentForDeliveryParams
        > {
  final UpdateShipmentForDeliveryRepo updateShipmentForDeliveryRepo;

  UpdateShipmentForDeliveryUseCase(this.updateShipmentForDeliveryRepo);

  @override
  Future<Either<Failure, UpdateShipmentForDeliveryEntity>> call([
    UpdateShipmentForDeliveryParams? params,
  ]) async {
    return await updateShipmentForDeliveryRepo.updateShimentForDelivery(
      photo: params!.photo,
      idDelivery: params.idDelivery,
      actualParcelsCount: params.actualParcelsCount,
      idShipment: params.idShipment,
    );
  }
}

class UpdateShipmentForDeliveryParams {
  final int idDelivery;
  final int idShipment;
  final int actualParcelsCount;
  final XFile photo;

  UpdateShipmentForDeliveryParams({
    required this.idDelivery,
    required this.idShipment,
    required this.actualParcelsCount,
    required this.photo,
  });
}
