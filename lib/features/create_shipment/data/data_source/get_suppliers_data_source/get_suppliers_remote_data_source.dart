import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/create_shipment/data/models/supplier_model/supplier_model.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/supplier_entity/supplier_entity.dart';

abstract class GetSuppliersRemoteDataSource {
  Future<List<SupplierEntity>> getSuppliers();
}

class GetSuppliersRemoteDataSourceImpl implements GetSuppliersRemoteDataSource {
  final ApiService apiService;

  GetSuppliersRemoteDataSourceImpl(this.apiService);
  @override
  Future<List<SupplierEntity>> getSuppliers() async{
    final token = await sl.get<AuthLocalDataSource>().getToken();
    var data = await apiService.get(
      endPoint: 'get/suppliers',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (data['data'] == null) {
      return [];
    }
    List<SupplierEntity> suppliers = [];
    for (var element in data['data']) {
      suppliers.add(SupplierModel.fromJson(element));
    }

    return suppliers;
  }
}
