import 'package:dio/dio.dart';
import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/data/models/update_parcel_info_model/update_parcel_info_model.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/update_parcel_info_entity/update_parcel_info_entity.dart';
import 'package:image_picker/image_picker.dart';

abstract class UpdateParcelInfoRemoteDataSource {
  Future<UpdateParcelInfoEntity> updateParceInfo({
    required int parcelId,
    required bool isOpend,
    required String openedNotes,
    required bool isDamaged,
    required String damagedNotes,
    required num newActualWeight,
    required String notes,
    required XFile scaledPhoto,
    required String status,
  });
}

class UpdateParcelInfoRemoteDataSourceImpl
    implements UpdateParcelInfoRemoteDataSource {
  final ApiService _apiService;

  UpdateParcelInfoRemoteDataSourceImpl(this._apiService);

  @override
Future<UpdateParcelInfoEntity> updateParceInfo({
  required int parcelId,
  required bool isOpend,
  required String openedNotes,
  required bool isDamaged,
  required String damagedNotes,
  required num newActualWeight,
  required String notes,           // ليس مستخدمًا في هذا الـ endpoint حسب Postman
  required XFile scaledPhoto,
  required String status,
}) async {
  final token = await sl.get<AuthLocalDataSource>().getToken();

  // تجهيز الـ FormData بنفس ما ترسله في Postman (كلها نصوص + ملف)
  final formData = FormData.fromMap({
    'is_opened': (isOpend ? 1 : 0).toString(),
    'opened_notes': openedNotes,
    'is_damaged': (isDamaged ? 1 : 0).toString(),
    'damaged_notes': damagedNotes,
    'new_actual_weight': newActualWeight.toString(),
    'status': status,
    'updated_scale_photo_upload': await MultipartFile.fromBytes(
      await scaledPhoto.readAsBytes(),
      filename: scaledPhoto.name,
    ),
  });

  // طباعة للتأكد مما يُرسل
  print('================ Parcel FormData ================');
  for (final f in formData.fields) {
    print('${f.key}: ${f.value}');
  }
  for (final f in formData.files) {
    print('${f.key}: filename=${f.value.filename}');
  }
  print('=================================================');

  try {
    // إرسال الطلب
    final data = await _apiService.post(
      endPoint: 'update/parcel-info/$parcelId',
      data: formData,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data', // Dio سيضبط boundary تلقائيًا
      },
      // إن كان ApiService يدعم خيارات Dio، خلِّيه لا يرمي على 4xx حتى تشوف رسالة السيرفر:
      // options: Options(validateStatus: (s) => s != null && s < 500),
    );

    // حوّل الرد إلى الموديل/الكيان الحقيقي
    final entity = UpdateParcelInfoModel.fromJson(data);
    return entity;
  } on DioException catch (e) {
    // لوج مفيد لتحديد السبب بدقة
    print('DioException type: ${e.type}');
    print('Status: ${e.response?.statusCode}');
    print('Data: ${e.response?.data}');
    rethrow;
  }
}

}
