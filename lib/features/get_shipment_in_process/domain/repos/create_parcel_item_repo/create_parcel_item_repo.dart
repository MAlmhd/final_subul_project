import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_parcel_item_entity/create_parcel_item_entity.dart';

abstract class CreateParcelItemRepo {
  Future<Either<Failure, CreateParcelItemEntity>> createParcelItem({
    required int id,
    required String type,
    required int quantity,
    required int valuePerItem,
    required String description,
  });
}
