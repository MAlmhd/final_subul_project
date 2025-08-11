import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/update_shipment_destenation_data_source/update_shipment_destenation_remote_date_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_destenation_country_entity/update_destenation_country_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/update_shipment_destenation_country_repo/update_shipment_destenation_country_repo.dart';

class UpdateShipmentDestenationRepoImpl
    implements UpdateShipmentDestenationCountryRepo {
  final UpdateShipmentDestenationRemoteDateSource
  updateShipmentDestenationCountryRemoteDataSource;

  UpdateShipmentDestenationRepoImpl(
    this.updateShipmentDestenationCountryRemoteDataSource,
  );

  @override
  Future<Either<Failure, UpdateDestenationCountryEntity>> updateCountry({
    required int idShipment,
    required int idCountry,
  }) async {
    try {
      var data = await updateShipmentDestenationCountryRemoteDataSource
          .updateCountry(idShipment: idShipment, idCountry: idCountry);
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
