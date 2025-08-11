import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_customer_shipment/domain/entities/shipment_of_customer_entity.dart';
import 'package:final_subul_project/features/get_customer_shipment/domain/repos/get_customer_shipments.dart';

class GetCustomerShipmentsUseCase
    extends UseCase<List<ShipmentOfCustomerEntity>, String> {
  final GetCustomerShipmentsRepo getCustomerShipments;

  GetCustomerShipmentsUseCase(this.getCustomerShipments);
  @override
  Future<Either<Failure, List<ShipmentOfCustomerEntity>>> call([
    String? code,
  ]) async {
    return await getCustomerShipments.getCustomerShipments(code: code!);
  }
}
