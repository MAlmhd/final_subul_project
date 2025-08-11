import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/models/create_parcel_model/create_parcel_model.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_parcel_entity/create_parcel_entity.dart';

abstract class CreateParcelRemoteDataSource {
  Future<CreateParcelEntity> createParcel({
    required int id,
    required int actualWeight,
    required int specialActualWeight,
    required int normalActualWeight,
    required int specialDimensionalWeight,
    required int normalDimensionalWeight,
    required int length,
    required int width,
    required int height,
    required String brandType,
    required bool isFragile,
    required bool needsRepacking,
    required String notes,
    required String printNotes,
    required XFile scalePhotoUpload,
  });
}

class CreateParcelRemoteDataSourceImpl implements CreateParcelRemoteDataSource {
  final ApiService _apiService;

  CreateParcelRemoteDataSourceImpl(this._apiService);
  @override
  Future<CreateParcelEntity> createParcel({
    required int id,
    required int actualWeight,
    required int specialActualWeight,
    required int normalActualWeight,
    required int specialDimensionalWeight,
    required int normalDimensionalWeight,
    required int length,
    required int width,
    required int height,
    required String brandType,
    required bool isFragile,
    required bool needsRepacking,
    required String notes,
    required String printNotes,
    required XFile scalePhotoUpload,
  }) async {
    final token = await sl.get<AuthLocalDataSource>().getToken();

    final scalePhoto = MultipartFile.fromBytes(
      await scalePhotoUpload.readAsBytes(),
      filename: scalePhotoUpload.name,
    );

    FormData formData = FormData.fromMap({
      'actual_weight': actualWeight,
      'special_actual_weight': specialActualWeight,
      'normal_actual_weight': normalActualWeight,
      'length': length,
      'width': width,
      'height': height,
      'scale_photo_upload': scalePhoto,
      'brand_type': brandType,
      'is_fragile': isFragile ? 1 : 0,
      'needs_repacking': needsRepacking ? 1 : 0,
      'notes': notes,
      'print_notes': printNotes,
      'special_dimensional_weight': specialDimensionalWeight,
      'normal_dimensional_weight': normalDimensionalWeight,
    });

    var response = await _apiService.post(
      endPoint: 'create/parcel/$id',
      headers: {'Authorization': 'Bearer $token'},
      data: formData,
    );

    CreateParcelEntity entity = CreateParcelModel.fromJson(response);

    return entity;
  }
}
