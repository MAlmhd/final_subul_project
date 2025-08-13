import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/create_shipment_entity/create_shipment_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/repos/create_shipment_repo/create_shipment_repo.dart';

class CreateShipmentUseCase
    extends UseCase<CreateShipmentEntity, CreateShipmentParams> {
  final CreateShipmentRepo createShipmentRepo;

  CreateShipmentUseCase(this.createShipmentRepo);
  @override
  Future<Either<Failure, CreateShipmentEntity>> call([
    CreateShipmentParams? params,
  ]) async {
    return await createShipmentRepo.createShipment(
      type: params!.type,
      customerId: params.customerId,
      supplierId: params.supplierId,
      declaredParcelsCount: params.declaredParcelsCount,
      notes: params.notes,
      originCountryId: params.originCountryId,
      destenationCountryId: params.destenationCountryId,
    );
  }
}

class CreateShipmentParams {
  final String type;
  final int customerId;
  final int supplierId;
  final String declaredParcelsCount;
  final String notes;
  final int originCountryId;
  final int destenationCountryId;

  CreateShipmentParams({required this.type, required this.customerId, required this.supplierId, required this.declaredParcelsCount, required this.notes, required this.originCountryId, required this.destenationCountryId});

  
}
