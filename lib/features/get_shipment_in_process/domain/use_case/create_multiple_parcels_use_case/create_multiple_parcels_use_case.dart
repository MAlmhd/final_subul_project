import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/helpers/create_parcels_request.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_multiple_parcels_entity/create_multiple_parcels_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/create_multiple_parcels_repo/create_multiple_parcels_repo.dart';

class CreateMultipleParcelsUseCase
    extends UseCase<CreateMultipleParcelsEntity, CreateMultipleParcelsParams> {
  final CreateMultipleParcelsRepo createMultipleParcelsRepo;

  CreateMultipleParcelsUseCase(this.createMultipleParcelsRepo);
  @override
  Future<Either<Failure, CreateMultipleParcelsEntity>> call([
    CreateMultipleParcelsParams? params,
  ]) async {
    return await createMultipleParcelsRepo.createMultipleParcels(
      shipmentId: params!.shipmentId,
      parcels: params.items,
    );
  }
}

class CreateMultipleParcelsParams {
  final int shipmentId;
  final List<ParcelRequest> items;

  CreateMultipleParcelsParams({required this.shipmentId, required this.items});
}
