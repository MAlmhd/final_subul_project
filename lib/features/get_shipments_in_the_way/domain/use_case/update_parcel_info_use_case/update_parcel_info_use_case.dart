import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/update_parcel_info_entity/update_parcel_info_entity.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/repos/update_parcel_info_repo/update_parcel_info_repo.dart';
import 'package:image_picker/image_picker.dart';

class UpdateParcelInfoUseCase
    extends UseCase<UpdateParcelInfoEntity, UpdateParcelInfoParams> {
  final UpdateParcelInfoRepo updateParcelInfoRepo;

  UpdateParcelInfoUseCase(this.updateParcelInfoRepo);
  @override
  Future<Either<Failure, UpdateParcelInfoEntity>> call([
    UpdateParcelInfoParams? params,
  ]) async {
    return await updateParcelInfoRepo.updateParcel(
      parcelId: params!.parcelId,
      isOpend: params.isOpend,
      openedNotes: params.openedNotes,
      isDamaged: params.isDamaged,
      damagedNotes: params.damagedNotes,
      newActualWeight: params.newActualWeight,
      notes: params.notes,
      scaledPhoto: params.scaledPhoto,
      status: params.status,
    );
  }
}

class UpdateParcelInfoParams {
  final int parcelId;
  final bool isOpend;
  final String openedNotes;
  final String status;
  final bool isDamaged;
  final String damagedNotes;
  final num newActualWeight;
  final String notes;
  final XFile scaledPhoto;

  UpdateParcelInfoParams({
    required this.status, 
    required this.parcelId,
    required this.isOpend,
    required this.openedNotes,
    required this.isDamaged,
    required this.damagedNotes,
    required this.newActualWeight,
    required this.notes,
    required this.scaledPhoto,
  });
}
