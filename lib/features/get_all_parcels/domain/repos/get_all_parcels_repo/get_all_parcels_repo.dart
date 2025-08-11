import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_all_parcels/domain/entities/parcel_entity/parcel_entity.dart';

abstract class GetAllParcelsRepo {
  Future<Either<Failure, List<ParcelEntity>>> getAllParcels();
}
