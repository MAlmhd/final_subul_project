import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/get_deliverable_shipments_entity/get_deliverable_shipments_entity.dart';

abstract class GetDeliverableShipmentsRepo {
  Future<Either<Failure,List<GetDeliverableShipmentsEntity>>> getDeliverableShipments();
}