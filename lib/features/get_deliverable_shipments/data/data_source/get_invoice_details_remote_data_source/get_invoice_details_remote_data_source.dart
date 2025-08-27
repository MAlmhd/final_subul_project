import 'dart:developer';

import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/data/models/Invoice_details_response_model/invoice_details_response_model.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/get_invoice_details_entity/get_invoice_details_entity.dart';

abstract class GetInvoiceDetailsRemoteDataSource {
  Future<InvoiceDetailsResponseEntity> getInvoiceDetails({required int id});
}

class GetInvoiceDetailsRemoteDataSourceImpl
    implements GetInvoiceDetailsRemoteDataSource {
  final ApiService _apiService;

  GetInvoiceDetailsRemoteDataSourceImpl(this._apiService);
  @override
  Future<InvoiceDetailsResponseEntity> getInvoiceDetails({
    required int id,
  }) async {
    final token = await sl.get<AuthLocalDataSource>().getToken();
    log("id : $id");
    log("token : $token");
    var response = await _apiService.get(
      endPoint: 'get/invoice-details/$id',
      headers: {'Authorization': 'Bearer $token'},
    );

    InvoiceDetailsResponseEntity entity = InvoiceDetailsResponseModel.fromJson(
      response,
    );
    return entity;
  }
}
