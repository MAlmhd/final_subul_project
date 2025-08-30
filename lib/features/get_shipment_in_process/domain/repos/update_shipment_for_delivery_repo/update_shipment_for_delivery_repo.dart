import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_shipment_for_delivery_entity/update_shipment_for_delivery_entity.dart';

abstract class UpdateShipmentForDeliveryRepo {
  Future<Either<Failure, UpdateShipmentForDeliveryEntity>>
  updateShimentForDelivery({
    required XFile photo,
    required int idDelivery,
    required int actualParcelsCount,
    required int idShipment,
    required int flightId,
  });
}
