import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/country_entity/country_entity.dart';

abstract class GetCountriesRepo {
  Future<Either<Failure, List<CountryEntity>>> getCountries();
}
