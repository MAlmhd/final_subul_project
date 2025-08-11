import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/create_shipment/data/models/country_model/country_model.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/country_entity/country_entity.dart';

abstract class GetCountriesRemoteDataSource {
  Future<List<CountryEntity>> getCountries();
}

class GetCountriesRemoteDataSourceImpl implements GetCountriesRemoteDataSource {
  final ApiService _apiService;

  GetCountriesRemoteDataSourceImpl(this._apiService);
  @override
  Future<List<CountryEntity>> getCountries() async {
    final token = await sl.get<AuthLocalDataSource>().getToken();
    var data = await _apiService.get(
      endPoint: 'get/enabled-countries',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (data['data'] == null) {
      return [];
    }
    List<CountryEntity> countries = [];
    for (var element in data['data']) {
      countries.add(CountryModel.fromJson(element));
    }

    return countries;
  }
}
