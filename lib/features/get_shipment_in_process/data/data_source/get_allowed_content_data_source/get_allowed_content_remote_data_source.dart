import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/models/allowed_content_model/allowed_content_model.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/allowed_content_entity/allowed_content_entity.dart';

abstract class GetAllowedContentRemoteDataSource {
  Future<List<AllowedContentEntity>> getAllowedContent();
}

class GetAllowedContentRemoteDataSourceImpl
    implements GetAllowedContentRemoteDataSource {
  final ApiService _apiService;

  GetAllowedContentRemoteDataSourceImpl(this._apiService);
  @override
  Future<List<AllowedContentEntity>> getAllowedContent() async {
    final token = await sl.get<AuthLocalDataSource>().getToken();
    var data = await _apiService.get(
      endPoint: 'get/allowed-parcel-content',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (data['data'] == null) {
      return [];
    }

    List<AllowedContentEntity> content = [];
    for (var element in data['data']) {
      content.add(AllowedContentModel.fromJson(element));
    }

    return content;
  }
}
