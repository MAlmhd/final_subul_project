import 'dart:developer';

import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/create_shipment/data/models/create_shipment_model/create_shipment_model/create_shipment_model.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/create_shipment_entity/create_shipment_entity.dart';

abstract class CreateShipmentRemoteDataSource {
  Future<CreateShipmentEntity> createShipment({
    required String type,
    required int customerId,
    required int supplierId,
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
  Future<CreateShipmentEntity> createShipment({
    required String type,
    required int customerId,
  required int supplierId,
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
        'supplier_id':supplierId,
        'declared_parcels_count': declaredParcelsCount,
        'notes': notes,
        'origin_country_id': originCountryId,
        'destination_country_id': destenationCountryId,
      },
      headers: {'Authorization': 'Bearer $token'},
    );
    log("$data");

    CreateShipmentEntity entity =
        CreateShipmentModel.fromJson(data);

    return entity;
  }
}
