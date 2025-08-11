import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_destenation_country_entity/update_destenation_country_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/update_shipment_destenation_country_repo/update_shipment_destenation_country_repo.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/update_shipment_origin_country_use_case/update_shipment_origin_use_case.dart';

class UpdateShipmentDestenationCountryUseCase
    extends UseCase<UpdateDestenationCountryEntity, UpdateCountryParam> {
  final UpdateShipmentDestenationCountryRepo
  updateShipmentDestenationCountryRepo;

  UpdateShipmentDestenationCountryUseCase(
    this.updateShipmentDestenationCountryRepo,
  );
  @override
  Future<Either<Failure, UpdateDestenationCountryEntity>> call([
    UpdateCountryParam? params,
  ]) async {
    return await updateShipmentDestenationCountryRepo.updateCountry(
      idShipment: params!.idShipment,
      idCountry: params.idCountry,
    );
  }
}
