import 'dart:developer';

import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/create_shipment/data/models/response_of_create_shipment_model/response_of_create_shipment_model/response_of_create_shipment_model.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/response_of_create_shipment_entity/response_of_create_shipment_entity.dart';

abstract class CreateShipmentRemoteDataSource {
  Future<ResponseOfCreateShipmentEntity> createShipment({
    required String type,
    required int customerId,
    required String supplierName,
    required String supplierNumber,
    required String declaredParcelsCount,
    required String notes,
    required int originCountryId,
    required int destenationCountryId,
  });
}

class CreateShipmentRemoteDataSourceImpl
    implements CreateShipmentRemoteDataSource {
  final ApiService _apiService;

  CreateShipmentRemoteDataSourceImpl(this._apiService);
  @override
  Future<ResponseOfCreateShipmentEntity> createShipment({
    required String type,
    required int customerId,
    required String supplierName,
    required String supplierNumber,
    required String declaredParcelsCount,
    required String notes,
    required int originCountryId,
    required int destenationCountryId,
  }) async {
    final token = await sl.get<AuthLocalDataSource>().getToken();
    var data = await _apiService.post(
      endPoint: 'create/shipments',
      data: {
        'type': type,
        'customer_id': customerId,
        'supplier_name': supplierName,
        'supplier_number': supplierNumber,
        'declared_parcels_count': declaredParcelsCount,
        'notes': notes,
        'origin_country_id': originCountryId,
        'destination_country_id': destenationCountryId,
      },
      headers: {'Authorization': 'Bearer $token'},
    );
    log("$data");

    ResponseOfCreateShipmentEntity entity =
        ResponseOfCreateShipmentModel.fromJson(data);

    return entity;
  }
}
