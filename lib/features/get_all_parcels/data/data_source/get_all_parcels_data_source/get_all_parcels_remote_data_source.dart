import 'dart:developer';

import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_all_parcels/data/models/get_all_parcels_model/get_all_parcels_model.dart';
import 'package:final_subul_project/features/get_all_parcels/domain/entities/parcel_entity/parcel_entity.dart';

abstract class GetAllParcelsRemoteDataSource {
  Future<List<ParcelEntity>> getAllParcels();
}

class GetAllParcelsRemoteDataSourceImpl
    implements GetAllParcelsRemoteDataSource {
  final ApiService _apiService;

  GetAllParcelsRemoteDataSourceImpl(this._apiService);
  @override
  Future<List<ParcelEntity>> getAllParcels() async {
    final token = await sl.get<AuthLocalDataSource>().getToken();
    var data = await _apiService.get(
      endPoint: 'get/all/parcels',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (data['data'] == null) {
      return [];
    }

    List<ParcelEntity> parcels = [];
    for (var element in data['data']) {
      parcels.add(GetAllParcelsModel.fromJson(element));
    }

    return parcels;
  }
}
