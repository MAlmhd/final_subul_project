import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/register_client/domain/entites/company_entity/company_entity.dart';

abstract class GetCompaniesRepo {
  Future<Either<Failure, List<CompanyEntity>>> getCompanies();
}
