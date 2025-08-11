import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/get_parcel_items_entity/get_parcel_items_entity.dart';

abstract class GetParcelItemsRepo {
  Future<Either<Failure, List<GetParcelItemsEntity>>> getParcelItems({
    required int id,
  });
}
