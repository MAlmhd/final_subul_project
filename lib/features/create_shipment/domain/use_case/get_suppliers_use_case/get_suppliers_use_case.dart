import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/supplier_entity/supplier_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/repos/get_suppliers/get_suppliers_repo.dart';

class GetSuppliersUseCase extends UseCase<List<SupplierEntity>, NoParam> {
  final GetSuppliersRepo getSuppliersRepo;

  GetSuppliersUseCase(this.getSuppliersRepo);
  @override
  Future<Either<Failure, List<SupplierEntity>>> call([NoParam? params]) async {
    return await getSuppliersRepo.getSuppliers();
  }
}
