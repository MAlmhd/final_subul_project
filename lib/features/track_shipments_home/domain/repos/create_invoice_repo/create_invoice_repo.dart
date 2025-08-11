import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/track_shipments_home/domain/entities/bill_entity/bill_entity.dart';

abstract class CreateInvoiceRepo {
  Future<Either<Failure, BillEntity>> createInvoice({
    required int customerId,
    required int shipmentId,
    required double amount,
    required bool includesTax,
    required String payableAt,
  });
}
