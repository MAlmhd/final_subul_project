import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/create_shipment/data/data_source/get_suppliers_data_source/get_suppliers_remote_data_source.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/supplier_entity/supplier_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/repos/get_suppliers/get_suppliers_repo.dart';

class GetSuppliersRepoImpl implements GetSuppliersRepo {
  final GetSuppliersRemoteDataSource getSuppliersRemoteDataSource;

  GetSuppliersRepoImpl(this.getSuppliersRemoteDataSource);
  @override
  Future<Either<Failure, List<SupplierEntity>>> getSuppliers() async {
    try {
      var data = await getSuppliersRemoteDataSource.getSuppliers();
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
