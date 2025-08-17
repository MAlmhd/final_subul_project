import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/get_invoice_details_entity/get_invoice_details_entity.dart';

abstract class GetInvoiceDetailsRepo {
  Future<Either<Failure, InvoiceDetailsResponseEntity>> getInvoiceDetails({required int shipmentId});
}
