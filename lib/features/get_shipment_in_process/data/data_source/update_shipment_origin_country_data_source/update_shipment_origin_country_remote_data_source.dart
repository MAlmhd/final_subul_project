import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/models/update_origin_country_model/update_origin_country_model.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_origin_country_entity/update_origin_country_entity.dart';

abstract class UpdateShipmentOriginCountryRemoteDataSource {
  Future<UpdateOriginCountryEntity> updateCountry({
    required int idCountry,
    required int idShipment,
  });
}

class UpdateShipmentOriginCountryRemoteDataSourceImpl
    implements UpdateShipmentOriginCountryRemoteDataSource {
  final ApiService _apiService;

  UpdateShipmentOriginCountryRemoteDataSourceImpl(this._apiService);
  @override
  Future<UpdateOriginCountryEntity> updateCountry({
    required int idCountry,
    required int idShipment,
  }) async {
    final token = await sl.get<AuthLocalDataSource>().getToken();
    var data = await _apiService.post(
      endPoint: 'shipments/$idShipment/origin-country/$idCountry',
      headers: {'Authorization': 'Bearer $token'},
    );

    UpdateOriginCountryEntity entity = UpdateOriginCountryModel.fromJson(data);

    return entity;
  }
}
