import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_customer_shipment/domain/entities/shipment_of_customer_entity.dart';

abstract class GetCustomerShipmentsRepo {
  Future<Either<Failure, List<ShipmentOfCustomerEntity>>> getCustomerShipments({
    required String code,
  });
}
