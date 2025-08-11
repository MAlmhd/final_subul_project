import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/get_shipment_details_data_source/get_shipment_details_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/data/data_source/get_shipments_in_the_way_data_source/get_shipments_in_the_way_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/shipment_in_the_way_entity/shipment_in_the_way_entity.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/repos/get_shipments_in_the_way_repo/get_shipments_in_the_way_repo.dart';

class GetShipmentsInTheWayRepoImpl implements GetShipmentsInTheWayRepo {
  final GetShipmentsInTheWayRemoteDataSource
  getShipmentsInTheWayRemoteDataSource;

  GetShipmentsInTheWayRepoImpl(this.getShipmentsInTheWayRemoteDataSource);
  @override
  Future<Either<Failure, List<ShipmentInTheWayEntity>>>
  getShipmentsInTheWay() async {
    try {
      var data =
          await getShipmentsInTheWayRemoteDataSource.getShipmentsInTheWay();
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
