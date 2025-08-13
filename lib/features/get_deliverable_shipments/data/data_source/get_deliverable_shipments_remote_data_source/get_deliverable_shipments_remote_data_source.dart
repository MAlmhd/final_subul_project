import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/data/models/get_deliverable_shipments_model/get_deliverable_shipments_model.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/get_deliverable_shipments_entity/get_deliverable_shipments_entity.dart';

abstract class GetDeliverableShipmentsRemoteDataSource {
  Future<List<GetDeliverableShipmentsEntity>> getDeliverableShipments();
}

class GetDeliverableShipmentsRemoteDataSourceImpl
    implements GetDeliverableShipmentsRemoteDataSource {
  final ApiService _apiService;

  GetDeliverableShipmentsRemoteDataSourceImpl(this._apiService);
  @override
  Future<List<GetDeliverableShipmentsEntity>> getDeliverableShipments() async{
     final token = await sl.get<AuthLocalDataSource>().getToken();

    var data = await _apiService.get(
      endPoint: 'get/deliverable-shipments',
      headers: {'Authorization': 'Bearer $token'},
    );

    List<GetDeliverableShipmentsEntity> shipments = [];
    if (data['data'] == null) {
      return [];
    }
    for (var element in data['data']) {
      shipments.add(GetDeliverableShipmentsModel.fromJson(element));
    }

    //  saveData<RejectedShipmentEntity>(shipments, kRejectedShipments);

    return shipments;
  }
}
