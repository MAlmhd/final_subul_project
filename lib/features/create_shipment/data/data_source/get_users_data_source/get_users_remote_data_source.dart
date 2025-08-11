import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/create_shipment/data/models/user_model/user_model.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/user_entity/user_entity.dart';

abstract class GetUsersRemoteDataSource {
  Future<List<UserEntity>> getUsers();
}

class GetUsersRemoteDataSourceImpl implements GetUsersRemoteDataSource {
  final ApiService _apiService;

  GetUsersRemoteDataSourceImpl(this._apiService);
  @override
  Future<List<UserEntity>> getUsers() async {
    final token = await sl.get<AuthLocalDataSource>().getToken();
    var data = await _apiService.get(
      endPoint: 'get/customers',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (data['data'] == null) {
      return [];
    }
    List<UserEntity> users = [];
    for (var element in data['data']) {
      users.add(UserModel.fromJson(element));
    }

    return users;
  }
}
