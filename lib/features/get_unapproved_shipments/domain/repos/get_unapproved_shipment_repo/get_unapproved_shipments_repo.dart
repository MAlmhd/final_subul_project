import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/entities/un_approved_shipment_entity/un_approved_shipments_entity.dart';

abstract class GetUnapprovedShipmentsRepo {
  Future<Either<Failure, List<UnApprovedShipmentsEntity>>>
  getUnapprovedShipments([String? searchItem]);
}
