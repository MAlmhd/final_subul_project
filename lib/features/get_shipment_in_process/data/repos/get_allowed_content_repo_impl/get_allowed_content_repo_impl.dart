import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/get_allowed_content_data_source/get_allowed_content_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/allowed_content_entity/allowed_content_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_allowed_content_repo/get_allowed_content_repo.dart';

class GetAllowedContentRepoImpl implements GetAllowedContentRepo {
  final GetAllowedContentRemoteDataSource getAllowedContentRemoteDataSource;

  GetAllowedContentRepoImpl(this.getAllowedContentRemoteDataSource);
  @override
  Future<Either<Failure, List<AllowedContentEntity>>>
  getAllowedContent() async {
    try {
      var data = await getAllowedContentRemoteDataSource.getAllowedContent();
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
