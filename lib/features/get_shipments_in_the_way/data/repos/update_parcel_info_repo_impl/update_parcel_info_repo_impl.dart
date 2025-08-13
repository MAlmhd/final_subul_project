import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/data/data_source/update_parcel_info_data_source/update_parcel_info_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/update_parcel_info_entity/update_parcel_info_entity.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/repos/update_parcel_info_repo/update_parcel_info_repo.dart';
import 'package:image_picker/image_picker.dart';

class UpdateParcelInfoRepoImpl implements UpdateParcelInfoRepo {
  final UpdateParcelInfoRemoteDataSource updateParcelInfoRemoteDataSource;

  UpdateParcelInfoRepoImpl(this.updateParcelInfoRemoteDataSource);
  @override
  Future<Either<Failure, UpdateParcelInfoEntity>> updateParcel({
    required int parcelId,
    required bool isOpend,
    required String openedNotes,
    required bool isDamaged,
    required String damagedNotes,
    required num newActualWeight,
    required String notes,
    required XFile scaledPhoto,
    required String status,
  }) async {
    try {
      var data = await updateParcelInfoRemoteDataSource.updateParceInfo(
        parcelId: parcelId,
        isOpend: isOpend,
        openedNotes: openedNotes,
        isDamaged: isDamaged,
        damagedNotes: damagedNotes,
        newActualWeight: newActualWeight,
        notes: notes,
        scaledPhoto: scaledPhoto,
        status: status,
      );
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
