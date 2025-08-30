import 'package:dio/dio.dart';
import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/create_shipment/data/models/create_shipment_model/create_shipment_model/create_shipment_model.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/create_shipment_entity/create_shipment_entity.dart';
import 'package:image_picker/image_picker.dart';

abstract class CreateShipmentRemoteDataSource {
  Future<CreateShipmentEntity> createShipment({
    required String type,
    required int customerId,
    required List<int> supplierIds,
    required String declaredParcelsCount,
    required String notes,
    required int originCountryId,
    required int destenationCountryId,
    required XFile invoiceFile,
  });
}

class CreateShipmentRemoteDataSourceImpl
    implements CreateShipmentRemoteDataSource {
  final ApiService _apiService;

  CreateShipmentRemoteDataSourceImpl(this._apiService);

  @override
  Future<CreateShipmentEntity> createShipment({
    required String type,
    required int customerId,
    required List<int> supplierIds,
    required String declaredParcelsCount,
    required String notes,
    required int originCountryId,
    required int destenationCountryId,
    required XFile invoiceFile,
  }) async {
    // 1) اجلب التوكن
    final token = await sl.get<AuthLocalDataSource>().getToken();

    // 2) جهّز الـ FormData بنفس مفاتيح Postman
    final formData = FormData();

    formData.fields.addAll([
      MapEntry('type', type),
      MapEntry('customer_id', customerId.toString()),
      MapEntry('origin_country_id', originCountryId.toString()),
      MapEntry('destination_country_id', destenationCountryId.toString()),
      MapEntry('declared_parcels_count', declaredParcelsCount),
      MapEntry('notes', notes),
    ]);

    // supplier_ids[0], supplier_ids[1], ...
    for (int i = 0; i < supplierIds.length; i++) {
      formData.fields.add(
        MapEntry('supplier_ids[$i]', supplierIds[i].toString()),
      );
    }

    // 3) أضف الملف
    formData.files.add(
      MapEntry(
        'invoice_file',
        await MultipartFile.fromFile(
          invoiceFile.path,
          filename: invoiceFile.name,
        ),
      ),
    );

    // 4) نفّذ الطلب
    final data = await _apiService.post(
      endPoint: 'create/shipments',
      data: formData,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        // لا تضبط Content-Type هنا؛ Dio يضع boundary تلقائياً للـ multipart
      },
    );

    // 5) حوّل الرد إلى الـ Entity
    return CreateShipmentModel.fromJson(data);
  }
}
