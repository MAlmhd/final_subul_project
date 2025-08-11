import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_parcel_entity/create_parcel_entity.dart';

abstract class CreateParcelRepo {
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
  });
}
