import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_origin_country_entity/update_origin_country_entity.dart';

abstract class UpdateShipmentOriginCountryRepo {
  Future<Either<Failure, UpdateOriginCountryEntity>> updateCountry({
    required int idShipment,
    required int idCountry,
  });
}
