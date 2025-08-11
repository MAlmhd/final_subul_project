import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_parcel_entity/create_parcel_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/create_parcel_repo/create_parcel_repo.dart';

class CreateParcelUseCase
    extends UseCase<CreateParcelEntity, CreateParcelParams> {
  final CreateParcelRepo createParcelRepo;

  CreateParcelUseCase(this.createParcelRepo);
  @override
  Future<Either<Failure, CreateParcelEntity>> call([
    CreateParcelParams? params,
  ]) async {
    return await createParcelRepo.createParcel(
      id: params!.id,
      actualWeight: params.actualWeight,
      specialActualWeight: params.specialActualWeight,
      normalActualWeight: params.normalActualWeight,
      specialDimensionalWeight: params.specialDimensionalWeight,
      normalDimensionalWeight: params.normalDimensionalWeight,
      length: params.length,
      width: params.width,
      height: params.height,
      brandType: params.brandType,
      isFragile: params.isFragile,
      needsRepacking: params.needsRepacking,
      notes: params.notes,
      printNotes: params.printNotes,
      scalePhotoUpload: params.scalePhotoUpload,
    );
  }
}

class CreateParcelParams {
  final int id;
  final int actualWeight;
  final int specialActualWeight;
  final int normalActualWeight;
  final int specialDimensionalWeight;
  final int normalDimensionalWeight;
  final int length;
  final int width;
  final int height;
  final String brandType;
  final bool isFragile;
  final bool needsRepacking;
  final String notes;
  final String printNotes;
  final XFile scalePhotoUpload;

  CreateParcelParams({
    required this.id,
    required this.actualWeight,
    required this.specialActualWeight,
    required this.normalActualWeight,
    required this.specialDimensionalWeight,
    required this.normalDimensionalWeight,
    required this.length,
    required this.width,
    required this.height,
    required this.brandType,
    required this.isFragile,
    required this.needsRepacking,
    required this.notes,
    required this.printNotes,
    required this.scalePhotoUpload,
  });
}
