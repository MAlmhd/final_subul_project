import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/driver_entity/driver_entity.dart';

abstract class GetDriversRepo {
  Future<Either<Failure, List<DriverEntity>>> getDrivers();
}
