import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/data/models/shipment_in_the_way_model/shipment_in_the_way_model.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/shipment_in_the_way_entity/shipment_in_the_way_entity.dart';

abstract class GetShipmentsInTheWayRemoteDataSource {
  Future<List<ShipmentInTheWayEntity>> getShipmentsInTheWay();
}

class GetShipmentsInTheWayRemoteDataSourceImpl
    implements GetShipmentsInTheWayRemoteDataSource {
  final ApiService _apiService;

  GetShipmentsInTheWayRemoteDataSourceImpl(this._apiService);
  @override
  Future<List<ShipmentInTheWayEntity>> getShipmentsInTheWay() async {
    final token = await sl.get<AuthLocalDataSource>().getToken();
    var data = await _apiService.get(
      endPoint: 'get/shipments/in-the-way',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (data['data'] == null) {
      return [];
    }

    List<ShipmentInTheWayEntity> shipments = [];
    for (var element in data['data']) {
      shipments.add(ShipmentInTheWayModel.fromJson(element));
    }

    return shipments;
  }
}
