// get_shipment_parcels_remote_data_source.dart
import 'dart:developer';

import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/models/specific_parcels_of_shipment_model/specific_parcels_of_shipment_model/specific_parcels_of_shipment_model.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/specific_parcels_of_shipment_entity/specific_parcels_of_shipment_entity.dart';

abstract class GetShipmentParcelsRemoteDataSource {
  Future<SpecificParcelsOfShipmentEntity> getShipmentParcels({
    required int shipmentId,
  });
}

class GetShipmentParcelsRemoteDataSourceImpl
    implements GetShipmentParcelsRemoteDataSource {
  final ApiService _apiService;

  GetShipmentParcelsRemoteDataSourceImpl(this._apiService);

  @override
  Future<SpecificParcelsOfShipmentEntity> getShipmentParcels({
    required int shipmentId,
  }) async {
    final token = await sl.get<AuthLocalDataSource>().getToken();

    final resp = await _apiService.get(
      endPoint: 'get/parcels/$shipmentId',
      headers: {'Authorization': 'Bearer $token'},
    );

    log("$resp");

    SpecificParcelsOfShipmentEntity entity =
        SpecificParcelsOfShipmentModel.fromJson(resp["data"]);
    return entity;
    // أو مباشرة بدون بناء shipment:
    // final parcelsJson = (dataMap['parcels'] as List<dynamic>?) ?? [];
    // return parcelsJson
    //     .map((e) => ParcelModel.fromJson(e as Map<String, dynamic>))
    //     .toList();
  }
}
