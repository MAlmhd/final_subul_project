import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/helpers/create_parcels_request.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/models/create_multiple_parcels_model/create_multiple_parcels_model.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_multiple_parcels_entity/create_multiple_parcels_entity.dart';

abstract class CreateMultipleParcelsRemoteDataSource {
  Future<CreateMultipleParcelsEntity> createMultipleParcels({
    required int shipmentId,
    required List<ParcelRequest> items,
  });
}

class CreateMultipleParcelsRemoteDataSourceImpl
    implements CreateMultipleParcelsRemoteDataSource {
  final ApiService _apiService;

  CreateMultipleParcelsRemoteDataSourceImpl(this._apiService);
  @override
  Future<CreateMultipleParcelsEntity> createMultipleParcels({
    required int shipmentId,
    required List<ParcelRequest> items,
  }) async {
    log("$items");
    final token = await sl.get<AuthLocalDataSource>().getToken();
    final formData = await buildParcelsFormData(items);
    var response = await _apiService.post(
      endPoint: 'create/multiple-parcels/$shipmentId',
      headers: {'Authorization': 'Bearer $token'},
      data: formData,
    );
    log("$response");

    CreateMultipleParcelsEntity entity = CreateMultipleParcelsModel.fromJson(
      response,
    );

    
    return entity;
  }
}

class ParcelItemDraft {
  final String itemType;
  final int quantity;
  final num valuePerItem;
  final String? description;
  ParcelItemDraft({
    required this.itemType,
    required this.quantity,
    required this.valuePerItem,
    this.description,
  });
}

class ParcelDraft {
  final num actualWeight;
  final num length;
  final num width;
  final num height;
  final String? brandType;
  final bool isFragile;
  final bool needsRepacking;
  final String? notes;
  final List<ParcelItemDraft> items;
  final String? imagePath; // مسار الصورة (اختياري)

  ParcelDraft({
    required this.actualWeight,
    required this.length,
    required this.width,
    required this.height,
    this.brandType,
    required this.isFragile,
    required this.needsRepacking,
    this.notes,
    required this.items,
    this.imagePath,
  });
}

/// يحول قائمة طرود إلى FormData بالمفاتيح مثل parcels[0][length] ...الخ
Future<FormData> buildParcelsFormData(List<ParcelRequest> parcels) async {
  final form = FormData();

  for (int p = 0; p < parcels.length; p++) {
    final parcel = parcels[p];

    // حقول الطرد
    form.fields.add(
      MapEntry('parcels[$p][actual_weight]', parcel.actualWeight.toString()),
    );
    form.fields.add(MapEntry('parcels[$p][length]', parcel.length.toString()));
    form.fields.add(MapEntry('parcels[$p][width]', parcel.width.toString()));
    form.fields.add(MapEntry('parcels[$p][height]', parcel.height.toString()));
    if (parcel.brandType != null && parcel.brandType!.isNotEmpty) {
      form.fields.add(MapEntry('parcels[$p][brand_type]', parcel.brandType!));
    }
    // بعض باكندات Laravel تفضّل 1/0 على true/false
    form.fields.add(
      MapEntry('parcels[$p][is_fragile]', parcel.isFragile ? '1' : '0'),
    );
    form.fields.add(
      MapEntry(
        'parcels[$p][needs_repacking]',
        parcel.needsRepacking ? '1' : '0',
      ),
    );
    if (parcel.notes != null && parcel.notes!.isNotEmpty) {
      form.fields.add(MapEntry('parcels[$p][notes]', parcel.notes!));
    }

    final scaledPhotoMultipart = MultipartFile.fromBytes(
      await parcel.scaledPhoto.readAsBytes(),
      filename: parcel.scaledPhoto.name,
    );
    form.files.add(
      MapEntry('parcels[$p][scale_photo_upload]', scaledPhotoMultipart),
    );

    for (int i = 0; i < parcel.items.length; i++) {
      final it = parcel.items[i];
      form.fields.add(
        MapEntry('parcels[$p][items][$i][item_type]', it.itemType),
      );
      form.fields.add(
        MapEntry('parcels[$p][items][$i][quantity]', it.quantity.toString()),
      );
      form.fields.add(
        MapEntry(
          'parcels[$p][items][$i][value_per_item]',
          it.valuePerItem.toString(),
        ),
      );
      if (it.description != null && it.description!.isNotEmpty) {
        form.fields.add(
          MapEntry('parcels[$p][items][$i][description]', it.description!),
        );
      }
    }
  }

  return form;
}
