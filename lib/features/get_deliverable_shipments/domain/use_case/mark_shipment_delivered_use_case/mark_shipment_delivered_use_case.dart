import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/mark_shipment_delivered_entity/mark_shipment_delivered_entity.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/repos/mark_shipment_delivered_repo/mark_shipment_delivered_repo.dart';
import 'package:image_picker/image_picker.dart';

class MarkShipmentDeliveredUseCase
    extends UseCase<MarkShipmentDeliveredEntity, MarkShipmentDeliveredParams> {
  final MarkShipmentDeliveredRepo markShipmentDeliveredRepo;

  MarkShipmentDeliveredUseCase(this.markShipmentDeliveredRepo);

  @override
  Future<Either<Failure, MarkShipmentDeliveredEntity>> call([
    MarkShipmentDeliveredParams? params,
  ]) async {
    return await markShipmentDeliveredRepo.markShipmentDelivered(
      shipmentId: params!.shipmentId,
      deliveryPhoto: params.deliveryPhoto,
    );
  }
}

class MarkShipmentDeliveredParams {
  final int shipmentId;
  final XFile deliveryPhoto;

  MarkShipmentDeliveredParams({
    required this.shipmentId,
    required this.deliveryPhoto,
  });
}
