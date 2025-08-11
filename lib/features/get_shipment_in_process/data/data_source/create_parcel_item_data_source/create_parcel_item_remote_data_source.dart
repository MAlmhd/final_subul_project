import 'package:dio/dio.dart';
import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/models/create_parcel_item_model/create_parcel_item_model.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_parcel_item_entity/create_parcel_item_entity.dart';

abstract class CreateParcelItemRemoteDataSource {
  Future<CreateParcelItemEntity> createParcelItem({
    required String type,
    required int quantity,
    required int valuePerItem,
    required String description,
    required int id,
  });
}

class CreateParcelItemRemoteDataSourceImpl
    implements CreateParcelItemRemoteDataSource {
  final ApiService _apiService;

  CreateParcelItemRemoteDataSourceImpl(this._apiService);
  @override
  Future<CreateParcelItemEntity> createParcelItem({
    required String type,
    required int quantity,
    required int valuePerItem,
    required String description,
    required int id,
  }) async {
    final token = await sl.get<AuthLocalDataSource>().getToken();

    var response = await _apiService.post(
      endPoint: 'create/parcel-item/$id',
      headers: {'Authorization': 'Bearer $token'},
      data: {
        'item_type': type,
        'quantity': quantity,
        'value_per_item': valuePerItem,
        'description': description,
      },
    );
    print(response);

    CreateParcelItemEntity entity = CreateParcelItemModel.fromJson(response);
    return entity;
  }
}
