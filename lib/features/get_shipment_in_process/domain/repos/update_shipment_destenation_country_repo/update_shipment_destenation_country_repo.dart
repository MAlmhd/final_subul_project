import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_destenation_country_entity/update_destenation_country_entity.dart';

abstract class UpdateShipmentDestenationCountryRepo {
  Future<Either<Failure, UpdateDestenationCountryEntity>> updateCountry({
    required int idShipment,
    required int idCountry,
  });
}
