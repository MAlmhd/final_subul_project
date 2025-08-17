import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/get_invoice_details_entity/get_invoice_details_entity.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/repos/get_invoice_details_repo/get_invoice_details_repo.dart';

class GetInvoiceDetailsUseCase
    extends UseCase<InvoiceDetailsResponseEntity, int> {
  final GetInvoiceDetailsRepo getInvoiceDetailsRepo;

  GetInvoiceDetailsUseCase(this.getInvoiceDetailsRepo);
  @override
  Future<Either<Failure, InvoiceDetailsResponseEntity>> call([
    int? params,
  ]) async {
    return await getInvoiceDetailsRepo.getInvoiceDetails(shipmentId: params!);
  }
}
