import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/data/data_source/update_shipments_warehouse_arrival_data_source/update_shipments_warehouse_arrival_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/update_shipments_warehouse_arrival_entity/update_shipments_warehouse_arrival_entity.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/repos/update_shipments_warehouse_arrival_repo/update_shipments_warehouse_arrival_repo.dart';

class UpdateShipmentsWarehouseArrivalRepoImpl
    implements UpdateShipmentsWarehouseArrivalRepo {
  final UpdateShipmentsWarehouseArrivalRemoteDataSource
  updateShipmentsWarehouseArrivalRemoteDataSource;

  UpdateShipmentsWarehouseArrivalRepoImpl(
    this.updateShipmentsWarehouseArrivalRemoteDataSource,
  );
  @override
  Future<Either<Failure, UpdateShipmentsWarehouseArrivalEntity>>
  updateShipment({required int id, required XFile image}) async {
    try {
      var data = await updateShipmentsWarehouseArrivalRemoteDataSource
          .updateShipments(id: id, image: image);
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
