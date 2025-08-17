import 'package:dio/dio.dart';
import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/data/models/mark_shipment_delivered_model/mark_shipment_delivered_model/mark_shipment_delivered_model.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/mark_shipment_delivered_entity/mark_shipment_delivered_entity.dart';
import 'package:image_picker/image_picker.dart';

abstract class MarkShipmentDeliveredRemoteDataSource {
  Future<MarkShipmentDeliveredEntity> markShipmentDelivered({
    required int shipmentId,
    required XFile deliveryPhoto,
  });
}

class MarkShipmentDeliveredRemoteDataSourceImpl
    implements MarkShipmentDeliveredRemoteDataSource {
  final ApiService _apiService;

  MarkShipmentDeliveredRemoteDataSourceImpl(this._apiService);
  @override
  Future<MarkShipmentDeliveredEntity> markShipmentDelivered({
    required int shipmentId,
    required XFile deliveryPhoto,
  }) async{
    final token = await sl.get<AuthLocalDataSource>().getToken();
    final deliveryPhotoMultipart = MultipartFile.fromBytes(
      await deliveryPhoto.readAsBytes(),
      filename: deliveryPhoto.name,
    );
   

    FormData formData = FormData.fromMap({
      'delivery_photo': deliveryPhotoMultipart,
    });

    var response = await _apiService.post(
      endPoint: 'mark-shipment-delivered/$shipmentId',
      headers: {'Authorization': 'Bearer $token'},
      data: formData,
    );

    MarkShipmentDeliveredEntity entity = MarkShipmentDeliveredModel.fromJson(
      response,
    );

    return entity;
  }
}
