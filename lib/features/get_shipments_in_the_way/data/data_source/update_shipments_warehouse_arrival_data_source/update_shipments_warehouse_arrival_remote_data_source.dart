import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/data/models/update_shipments_warehouse_arrival_model/update_shipments_warehouse_arrival_model.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/update_shipments_warehouse_arrival_entity/update_shipments_warehouse_arrival_entity.dart';

abstract class UpdateShipmentsWarehouseArrivalRemoteDataSource {
  Future<UpdateShipmentsWarehouseArrivalEntity> updateShipments({
    required int id,
    required XFile image,
  });
}

class UpdateShipmentsWarehouseArrivalRemoteDataSourceImpl
    implements UpdateShipmentsWarehouseArrivalRemoteDataSource {
  final ApiService _apiService;

  UpdateShipmentsWarehouseArrivalRemoteDataSourceImpl(this._apiService);
  @override
  Future<UpdateShipmentsWarehouseArrivalEntity> updateShipments({
    required int id,
    required XFile image,
  }) async {
    final token = await sl.get<AuthLocalDataSource>().getToken();

    final image1 = MultipartFile.fromBytes(
      await image.readAsBytes(),
      filename: image.name,
    );
    FormData formData = FormData.fromMap({'airport_receipt_photo': image1});

    var data = await _apiService.post(
      endPoint: 'update/shipments/warehouse-arrival/$id',
      headers: {'Authorization': 'Bearer $token'},
      data: formData,
    );

    UpdateShipmentsWarehouseArrivalEntity entity =
        UpdateShipmentsWarehouseArrivalModel.fromJson(data);

    return entity;
  }
}
