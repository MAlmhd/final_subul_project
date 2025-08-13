import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/update_parcel_info_entity/update_parcel_info_entity.dart';
import 'package:image_picker/image_picker.dart';

abstract class UpdateParcelInfoRepo {
  Future<Either<Failure, UpdateParcelInfoEntity>> updateParcel({required int parcelId,required bool isOpend,required String openedNotes,required bool isDamaged,required String damagedNotes,required num newActualWeight,required String notes,required XFile scaledPhoto,required String status,});
}
