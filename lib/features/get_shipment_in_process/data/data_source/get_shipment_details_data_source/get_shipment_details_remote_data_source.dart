import 'dart:developer';

import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/models/get_shipment_details_model/get_shipment_details_model.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/get_shipment_details_entity/get_shipment_details_entity.dart';

abstract class GetShipmentDetailsRemoteDataSource {
  Future<GetShipmentDetailsEntity> getShipments({required int idShipment});
}

class GetShipmentDetailsRemoteDataSourceImpl
    implements GetShipmentDetailsRemoteDataSource {
  final ApiService _apiService;

  GetShipmentDetailsRemoteDataSourceImpl(this._apiService);
  @override
  Future<GetShipmentDetailsEntity> getShipments({
    required int idShipment,
  }) async {
    final token = await sl.get<AuthLocalDataSource>().getToken();
    var data = await _apiService.get(
      endPoint: 'get/shipment-details/$idShipment',
      headers: {'Authorization': 'Bearer $token'},
    );

    GetShipmentDetailsEntity entity = GetShipmentDetailsModel.fromJson(
      data["data"],
    );
    return entity;
  }
}
