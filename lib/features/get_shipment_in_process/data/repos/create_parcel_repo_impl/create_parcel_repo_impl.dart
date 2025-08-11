import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/create_parcel_data_source/create_parcel_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_parcel_entity/create_parcel_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/create_parcel_repo/create_parcel_repo.dart';

class CreateParcelRepoImpl implements CreateParcelRepo {
  final CreateParcelRemoteDataSource createParcelRemoteDataSource;

  CreateParcelRepoImpl(this.createParcelRemoteDataSource);
  @override
  Future<Either<Failure, CreateParcelEntity>> createParcel({
    required int id,
    required int actualWeight,
    required int specialActualWeight,
    required int normalActualWeight,
    required int specialDimensionalWeight,
    required int normalDimensionalWeight,
    required int length,
    required int width,
    required int height,
    required String brandType,
    required bool isFragile,
    required bool needsRepacking,
    required String notes,
    required String printNotes,
    required XFile scalePhotoUpload,
  }) async {
    try {
      var data = await createParcelRemoteDataSource.createParcel(
        id: id,
        actualWeight: actualWeight,
        specialActualWeight: specialActualWeight,
        normalActualWeight: normalActualWeight,
        specialDimensionalWeight: specialDimensionalWeight,
        normalDimensionalWeight: normalDimensionalWeight,
        length: length,
        width: width,
        height: height,
        brandType: brandType,
        isFragile: isFragile,
        needsRepacking: needsRepacking,
        notes: notes,
        printNotes: printNotes,
        scalePhotoUpload: scalePhotoUpload,
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
