import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_customer_shipment/data/data_source/get_customer_shipments_remote_data_source.dart';
import 'package:final_subul_project/features/get_customer_shipment/domain/entities/shipment_of_customer_entity.dart';
import 'package:final_subul_project/features/get_customer_shipment/domain/repos/get_customer_shipments.dart';

class GetCustomerShipmentsRepoImpl implements GetCustomerShipmentsRepo {
  final GetCustomerShipmentsRemoteDataSource
  getCustomerShipmentsRemoteDataSource;

  GetCustomerShipmentsRepoImpl(this.getCustomerShipmentsRemoteDataSource);
  @override
  Future<Either<Failure, List<ShipmentOfCustomerEntity>>> getCustomerShipments({
    required String code,
  }) async {
    try {
      var data = await getCustomerShipmentsRemoteDataSource
          .getCustomerShipments(code: code);
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
