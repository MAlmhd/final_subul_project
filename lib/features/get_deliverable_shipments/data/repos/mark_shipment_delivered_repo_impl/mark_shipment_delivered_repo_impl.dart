import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/data/data_source/mark_shipment_deliverable_remote_data_source/mark_shipment_delivered_remote_data_source.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/mark_shipment_delivered_entity/mark_shipment_delivered_entity.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/repos/mark_shipment_delivered_repo/mark_shipment_delivered_repo.dart';
import 'package:image_picker/image_picker.dart';

class MarkShipmentDeliveredRepoImpl implements MarkShipmentDeliveredRepo {
  final MarkShipmentDeliveredRemoteDataSource
  markShipmentDeliveredRemoteDataSource;

  MarkShipmentDeliveredRepoImpl(this.markShipmentDeliveredRemoteDataSource);
  @override
  Future<Either<Failure, MarkShipmentDeliveredEntity>> markShipmentDelivered({
    required int shipmentId,
    required XFile deliveryPhoto,
  }) async {
    try {
      var data = await markShipmentDeliveredRemoteDataSource
          .markShipmentDelivered(
            shipmentId: shipmentId,
            deliveryPhoto: deliveryPhoto,
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
