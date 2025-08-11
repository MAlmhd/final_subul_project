import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/models/update_destenation_country_model/update_destenation_country_model.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_destenation_country_entity/update_destenation_country_entity.dart';

abstract class UpdateShipmentDestenationRemoteDateSource {
  Future<UpdateDestenationCountryEntity> updateCountry({
    required int idShipment,
    required int idCountry,
  });
}

class UpdateShipmentDestenationRemoteDateSourceImpl
    implements UpdateShipmentDestenationRemoteDateSource {
  final ApiService _apiService;

  UpdateShipmentDestenationRemoteDateSourceImpl(this._apiService);
  @override
  Future<UpdateDestenationCountryEntity> updateCountry({
    required int idShipment,
    required int idCountry,
  }) async {
    final token = await sl.get<AuthLocalDataSource>().getToken();
    var data = await _apiService.post(
      endPoint: 'shipments/$idShipment/destination-country/$idCountry',
      headers: {'Authorization': 'Bearer $token'},
    );

    UpdateDestenationCountryEntity entity =
        UpdateDestenationCountryModel.fromJson(data);

    return entity;
  }
}
