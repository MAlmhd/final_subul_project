import 'package:equatable/equatable.dart';
import 'package:final_subul_project/core/helpers/create_parcels_request.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_multiple_parcels_entity/create_multiple_parcels_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/create_multiple_parcels_use_case/create_multiple_parcels_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_multiple_parcels_state.dart';

class CreateMultipleParcelsCubit extends Cubit<CreateMultipleParcelsState> {
  final CreateMultipleParcelsUseCase createMultipleParcelsUseCase;
  CreateMultipleParcelsCubit(this.createMultipleParcelsUseCase)
    : super(CreateMultipleParcelsInitial());

  Future<void> createMultipleParcels({
    required int shipmentId,
    required List<ParcelRequest> parcels,
  }) async {
    emit(CreateMultipleParcelsLoading());
    CreateMultipleParcelsParams createMultipleParcelsParams =
        CreateMultipleParcelsParams(shipmentId: shipmentId, items: parcels);

    var data = await createMultipleParcelsUseCase.call(
      createMultipleParcelsParams,
    );
    data.fold(
      (failure) {
        emit(CreateMultipleParcelsFailure(failure.message));
      },
      (success) {
        emit(CreateMultipleParcelsSuccess(success));
      },
    );
  }
}
