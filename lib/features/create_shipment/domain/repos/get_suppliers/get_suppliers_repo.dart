import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/supplier_entity/supplier_entity.dart';

abstract class GetSuppliersRepo {
  Future<Either<Failure, List<SupplierEntity>>> getSuppliers();
}
