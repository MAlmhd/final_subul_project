import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/track_shipments_home/domain/entities/approved_shipment_entity/approved_shipment_entity.dart';

abstract class GetApprovedShipmentsRepo {
  Future<Either<Failure, List<ApprovedShipmentEntity>>> getApprovedShipments(
    String? searchItem,
  );
}
