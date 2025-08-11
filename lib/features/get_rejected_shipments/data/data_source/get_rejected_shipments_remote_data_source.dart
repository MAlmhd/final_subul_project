import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_rejected_shipments/data/models/rejected_shipment_model.dart';
import 'package:final_subul_project/features/get_rejected_shipments/domain/entities/rejected_shipment_entity.dart';

abstract class GetRejectedShipmentsRemoteDataSource {
  Future<List<RejectedShipmentEntity>> getrejectedShipments();
}

class GetRejectedShipmentsRemoteDataSourceImpl
    implements GetRejectedShipmentsRemoteDataSource {
  final ApiService _apiService;

  GetRejectedShipmentsRemoteDataSourceImpl(this._apiService);
  @override
  Future<List<RejectedShipmentEntity>> getrejectedShipments() async {
    final token = await sl.get<AuthLocalDataSource>().getToken();

    var data = await _apiService.get(
      endPoint: 'get/rejected/shipments',
      headers: {'Authorization': 'Bearer $token'},
    );

    List<RejectedShipmentEntity> shipments = [];
    if (data['data'] == null) {
      return [];
    }
    for (var element in data['data']) {
      shipments.add(RejectedShipmentModel.fromJson(element));
    }

    //  saveData<RejectedShipmentEntity>(shipments, kRejectedShipments);

    return shipments;
  }
}
