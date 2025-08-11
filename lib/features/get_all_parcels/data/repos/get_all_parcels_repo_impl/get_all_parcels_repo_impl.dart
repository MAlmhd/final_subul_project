import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_all_parcels/data/data_source/get_all_parcels_data_source/get_all_parcels_remote_data_source.dart';
import 'package:final_subul_project/features/get_all_parcels/domain/entities/parcel_entity/parcel_entity.dart';
import 'package:final_subul_project/features/get_all_parcels/domain/repos/get_all_parcels_repo/get_all_parcels_repo.dart';

class GetAllParcelsRepoImpl implements GetAllParcelsRepo {
  final GetAllParcelsRemoteDataSource getAllParcelsRemoteDataSource;

  GetAllParcelsRepoImpl(this.getAllParcelsRemoteDataSource);
  @override
  Future<Either<Failure, List<ParcelEntity>>> getAllParcels() async {
    try {
      var data = await getAllParcelsRemoteDataSource.getAllParcels();
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
