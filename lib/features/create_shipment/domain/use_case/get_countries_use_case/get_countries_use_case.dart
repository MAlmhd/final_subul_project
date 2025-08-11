import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/country_entity/country_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/repos/get_countries_repo/get_countries_repo.dart';

class GetCountriesUseCase extends UseCase<List<CountryEntity>, NoParam> {
  final GetCountriesRepo getCountriesRepo;

  GetCountriesUseCase(this.getCountriesRepo);
  @override
  Future<Either<Failure, List<CountryEntity>>> call([NoParam? params]) async {
    return await getCountriesRepo.getCountries();
  }
}
