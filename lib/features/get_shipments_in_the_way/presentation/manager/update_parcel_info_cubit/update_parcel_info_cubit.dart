import 'package:equatable/equatable.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/update_parcel_info_entity/update_parcel_info_entity.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/use_case/update_parcel_info_use_case/update_parcel_info_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'update_parcel_info_state.dart';

class UpdateParcelInfoCubit extends Cubit<UpdateParcelInfoState> {
  final UpdateParcelInfoUseCase updateParcelInfoUseCase;
  UpdateParcelInfoCubit(this.updateParcelInfoUseCase)
    : super(UpdateParcelInfoInitial());

  Future<void> updateParcelInfo({
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
    emit(UpdateParcelInfoLoading());
    UpdateParcelInfoParams updateParcelInfoParams = UpdateParcelInfoParams(
      status: status,
      parcelId: parcelId,
      isOpend: isOpend,
      openedNotes: openedNotes,
      isDamaged: isDamaged,
      damagedNotes: damagedNotes,
      newActualWeight: newActualWeight,
      notes: notes,
      scaledPhoto: scaledPhoto,
    );
    var data = await updateParcelInfoUseCase.call(updateParcelInfoParams);
    data.fold(
      (failure) {
        emit(UpdateParcelInfoFailure(failure.message));
      },
      (success) {
        emit(UpdateParcelInfoSuccess(success));
      },
    );
  }
}
