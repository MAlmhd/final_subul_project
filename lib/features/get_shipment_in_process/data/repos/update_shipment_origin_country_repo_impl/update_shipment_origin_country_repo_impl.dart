import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/update_shipment_origin_country_data_source/update_shipment_origin_country_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_origin_country_entity/update_origin_country_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/update_shipment_origin_country_repo/update_shipment_origin_country_repo.dart';

class UpdateShipmentOriginCountryRepoImpl
    implements UpdateShipmentOriginCountryRepo {
  final UpdateShipmentOriginCountryRemoteDataSource
  updateShipmentOriginCountryRemoteDataSource;

  UpdateShipmentOriginCountryRepoImpl(
    this.updateShipmentOriginCountryRemoteDataSource,
  );
  @override
  Future<Either<Failure, UpdateOriginCountryEntity>> updateCountry({
    required int idShipment,
    required int idCountry,
  }) async {
    try {
      var data = await updateShipmentOriginCountryRemoteDataSource
          .updateCountry(idCountry: idCountry, idShipment: idShipment);
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
