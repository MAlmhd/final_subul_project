import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/models/driver_model/driver_model.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/driver_entity/driver_entity.dart';

abstract class GetDriversRemoteDataSource {
  Future<List<DriverEntity>> getDrivers();
}

class GetDriversRemoteDataSourceImpl implements GetDriversRemoteDataSource {
  final ApiService _apiService;

  GetDriversRemoteDataSourceImpl(this._apiService);
  @override
  Future<List<DriverEntity>> getDrivers() async {
    final token = await sl.get<AuthLocalDataSource>().getToken();
    var data = await _apiService.get(
      endPoint: 'get/drivers',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (data['data'] == null) {
      return [];
    }
    List<DriverEntity> drivers = [];
    for (var element in data['data']) {
      drivers.add(DriverModel.fromJson(element));
    }

    return drivers;
  }
}
