import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/helpers/create_parcels_request.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_multiple_parcels_entity/create_multiple_parcels_entity.dart';

abstract class CreateMultipleParcelsRepo {
  Future<Either<Failure, CreateMultipleParcelsEntity>> createMultipleParcels({required int shipmentId,required List<ParcelRequest> parcels});
}
