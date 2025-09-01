import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/create_shipment_entity/create_shipment_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/repos/create_shipment_repo/create_shipment_repo.dart';
import 'package:image_picker/image_picker.dart';

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
      supplierIds: params.supplierIds,
      declaredParcelsCount: params.declaredParcelsCount,
      notes: params.notes,
      originCountryId: params.originCountryId,
      destenationCountryId: params.destenationCountryId,
      invoiceFile: params.invoiceFile,
    );
  }
}

class CreateShipmentParams {
  final String type;
  final int customerId;
  final List<int> supplierIds;
  final String? declaredParcelsCount;
  final String notes;
  final int originCountryId;
  final int destenationCountryId;
  final XFile invoiceFile;

  CreateShipmentParams({
    required this.type,
    required this.customerId,
    required this.supplierIds,
     this.declaredParcelsCount,
    required this.notes,
    required this.originCountryId,
    required this.destenationCountryId,
    required this.invoiceFile
  });
}
