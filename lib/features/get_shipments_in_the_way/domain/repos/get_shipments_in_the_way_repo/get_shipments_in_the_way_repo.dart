import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/shipment_in_the_way_entity/shipment_in_the_way_entity.dart';

abstract class GetShipmentsInTheWayRepo {
  Future<Either<Failure, List<ShipmentInTheWayEntity>>> getShipmentsInTheWay();
}
