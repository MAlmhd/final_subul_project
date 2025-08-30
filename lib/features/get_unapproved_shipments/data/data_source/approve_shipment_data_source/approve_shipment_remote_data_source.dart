import 'dart:developer';

import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/data/models/approve_shipment_model/response_of_approve_shipment_model.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/entities/response_of_approve_shipment_entity/response_of_approve_shipment_entity.dart';

abstract class ApproveShipmentRemoteDataSource {
  Future<ResponseOfApproveShipmentEntity> approve({required int id});
}

class ApproveShipmentRemoteDataSourceImpl
    implements ApproveShipmentRemoteDataSource {
  final ApiService _apiService;

  ApproveShipmentRemoteDataSourceImpl(this._apiService);
  @override
  Future<ResponseOfApproveShipmentEntity> approve({required int id}) async {
    final token = await sl.get<AuthLocalDataSource>().getToken();
    log("token : $token");
    log("id : $id");

    var response = await _apiService.post(
      endPoint: 'approve/shipment/$id',
      headers: {'Authorization': 'Bearer $token'},
    );
       log("id : $response");


    ResponseOfApproveShipmentEntity entity =
        ResponseOfApproveShipmentModel.fromJson(response);

    return entity;
  }
}
