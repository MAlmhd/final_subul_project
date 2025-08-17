import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/mark_shipment_delivered_entity/mark_shipment_delivered_entity.dart';
import 'package:image_picker/image_picker.dart';

abstract class MarkShipmentDeliveredRepo {
  Future<Either<Failure, MarkShipmentDeliveredEntity>> markShipmentDelivered({required int shipmentId,required XFile deliveryPhoto});
}
