import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/models/shipment_in_process_model/shipment_in_process_model.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/shipment_in_process_entity/shipment_in_process_entity.dart';

abstract class GetShipmentInProcessRemoteDataSource {
  Future<List<ShipmentInProcessEntity>> getShipments();
}

class GetShipmentInProcessRemoteDataSourceImpl
    implements GetShipmentInProcessRemoteDataSource {
  final ApiService _apiService;

  GetShipmentInProcessRemoteDataSourceImpl(this._apiService);
  @override
  Future<List<ShipmentInProcessEntity>> getShipments() async {
    final token = await sl.get<AuthLocalDataSource>().getToken();
    var data = await _apiService.get(
      endPoint: 'get/shipments/in-process',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (data['data'] == null) {
      return [];
    }
    List<ShipmentInProcessEntity> shipments = [];
    for (var element in data['data']) {
      shipments.add(ShipmentInProcessModel.fromJson(element));
    }

    return shipments;
  }
}
