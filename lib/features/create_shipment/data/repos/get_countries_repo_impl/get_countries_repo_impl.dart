import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/create_shipment/data/data_source/get_countries_data_source/get_countries_remote_data_source.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/country_entity/country_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/repos/get_countries_repo/get_countries_repo.dart';

class GetCountriesRepoImpl implements GetCountriesRepo {
  final GetCountriesRemoteDataSource getCountriesRemoteDataSource;

  GetCountriesRepoImpl(this.getCountriesRemoteDataSource);
  @override
  Future<Either<Failure, List<CountryEntity>>> getCountries() async {
    try {
      var data = await getCountriesRemoteDataSource.getCountries();
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
