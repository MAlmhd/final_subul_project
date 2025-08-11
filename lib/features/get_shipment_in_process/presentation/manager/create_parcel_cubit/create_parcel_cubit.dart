import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_parcel_entity/create_parcel_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/create_parcel_use_case/create_parcel_use_case.dart';

part 'create_parcel_state.dart';

class CreateParcelCubit extends Cubit<CreateParcelState> {
  final CreateParcelUseCase createParcelUseCase;
  CreateParcelCubit(this.createParcelUseCase) : super(CreateParcelInitial());

  Future<void> createParcel({
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
    emit(CreateParcelLoading());
    CreateParcelParams createParcelParams = CreateParcelParams(
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
    var data = await createParcelUseCase.call(createParcelParams);
    data.fold(
      (failure) {
        emit(CreateParcelFailure(failure.message));
      },
      (success) {
        emit(CreateParcelSuccess(success));
      },
    );
  }
}
