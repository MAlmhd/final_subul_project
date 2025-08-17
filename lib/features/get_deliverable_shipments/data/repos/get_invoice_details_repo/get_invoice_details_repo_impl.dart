import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/data/data_source/get_invoice_details_remote_data_source/get_invoice_details_remote_data_source.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/get_invoice_details_entity/get_invoice_details_entity.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/repos/get_invoice_details_repo/get_invoice_details_repo.dart';

class GetInvoiceDetailsRepoImpl implements GetInvoiceDetailsRepo {
  final GetInvoiceDetailsRemoteDataSource getInvoiceDetailsRemoteDataSource;

  GetInvoiceDetailsRepoImpl(this.getInvoiceDetailsRemoteDataSource);

  @override
  Future<Either<Failure, InvoiceDetailsResponseEntity>> getInvoiceDetails({
    required int shipmentId,
  }) async {
    try {
      var data = await getInvoiceDetailsRemoteDataSource.getInvoiceDetails(
        id: shipmentId,
      );
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
