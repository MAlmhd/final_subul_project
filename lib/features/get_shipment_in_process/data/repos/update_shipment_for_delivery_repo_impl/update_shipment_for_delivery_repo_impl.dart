import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/update_shipment_for_delivery_data_source/update_shipment_for_delivery_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_shipment_for_delivery_entity/update_shipment_for_delivery_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/update_shipment_for_delivery_repo/update_shipment_for_delivery_repo.dart';

class UpdateShipmentForDeliveryRepoImpl
    implements UpdateShipmentForDeliveryRepo {
  final UpdateShipmentForDeliveryRemoteDataSource
  updateShipmentForDeliveryRemoteDataSource;

  UpdateShipmentForDeliveryRepoImpl(
    this.updateShipmentForDeliveryRemoteDataSource,
  );
  @override
  Future<Either<Failure, UpdateShipmentForDeliveryEntity>>
  updateShimentForDelivery({
    required XFile photo,
    required int idDelivery,
    required int actualParcelsCount,
    required int idShipment,
  }) async {
    try {
      var data = await updateShipmentForDeliveryRemoteDataSource
          .updateShipmentForDelivery(
            photo: photo,
            idDelivery: idDelivery,
            actualParcelsCount: actualParcelsCount,
            idShipment: idShipment,
          );
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
