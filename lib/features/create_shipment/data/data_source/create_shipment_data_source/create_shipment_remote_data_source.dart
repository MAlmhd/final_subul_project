import 'dart:developer' as dev; // لطباعة منظّمة مع اسم ووقت
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

class CreateShipmentRemoteDataSourceImpl implements CreateShipmentRemoteDataSource {
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
    final token = await sl.get<AuthLocalDataSource>().getToken();

    // ── LOG: مدخلات الدالة
    dev.log('[CreateShipment] type=$type, customer_id=$customerId, '
        'declared_parcels_count=$declaredParcelsCount, origin=$originCountryId, dest=$destenationCountryId',
        name: 'CreateShipment');
    dev.log('[CreateShipment] suppliers=${supplierIds.join(', ')}', name: 'CreateShipment');
    dev.log('[CreateShipment] invoice_file name=${invoiceFile.name}', name: 'CreateShipment');

    final form = FormData();

    // الحقول العادية
    form.fields
      ..add(MapEntry('type', type))
      ..add(MapEntry('customer_id', customerId.toString()))
      ..add(MapEntry('declared_parcels_count', declaredParcelsCount))
      ..add(MapEntry('notes', notes))
      ..add(MapEntry('origin_country_id', originCountryId.toString()))
      ..add(MapEntry('destination_country_id', destenationCountryId.toString()));

    // ✅ الصيغة الصحيحة لمصفوفة لارافيل: supplier_ids[]
final uniqueSuppliers = supplierIds.toSet().toList();
for (final id in uniqueSuppliers) {
  form.fields.add(MapEntry('supplier_ids[0]', id.toString()));
}



    // الملف
    form.files.add(
      MapEntry(
        'invoice_file',
        await MultipartFile.fromFile(
          invoiceFile.path,
          filename: invoiceFile.name,
        ),
      ),
    );

   

    try {
      dev.log('[CreateShipment] POST -> create/shipments', name: 'CreateShipment');
      final data = await _apiService.post(
        endPoint: 'create/shipments',
        data: form,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      // ── LOG: الاستجابة
      dev.log('[CreateShipment] response: $data', name: 'CreateShipment');

      return CreateShipmentModel.fromJson(data);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final url = e.requestOptions.uri.toString();
      final msg = _extractServerMessage(e.response?.data);

      // ── LOG: تفاصيل الخطأ
      dev.log('[CreateShipment][DioError] status=$status method=${e.requestOptions.method} url=$url '
          'type=${e.type} message=${e.message} body=${e.response?.data}',
          name: 'CreateShipment', error: e, stackTrace: e.stackTrace);

      throw Exception('فشل إنشاء الشحنة (${status ?? '500'}): '
          '${msg.isNotEmpty ? msg : (e.message ?? 'Server Error')}');
    } catch (e, st) {
      dev.log('[CreateShipment][UnknownError] $e', name: 'CreateShipment', error: e, stackTrace: st);
      throw Exception('حدث خطأ غير متوقع أثناء إنشاء الشحنة: $e');
    }
  }
}


// ===== Helpers لاستخراج رسائل السيرفر (لارافيل) =====
String _extractServerMessage(dynamic data) {
  if (data == null) return '';
  if (data is Map) {
    final msg = (data['message'] ?? data['error'] ?? data['status_message'])?.toString();
    final errs = _collectLaravelErrors(data['errors']);
    if ((msg != null && msg.isNotEmpty) && errs.isNotEmpty) return '$msg | $errs';
    if (msg != null && msg.isNotEmpty) return msg;
    if (errs.isNotEmpty) return errs;
  }
  return data.toString();
}

String _collectLaravelErrors(dynamic errors) {
  if (errors is Map) {
    final out = <String>[];
    errors.forEach((k, v) {
      if (v is List) {
        for (final item in v) out.add('$k: $item');
      } else if (v != null) {
        out.add('$k: $v');
      }
    });
    return out.join(' | ');
  }
  return '';
}
