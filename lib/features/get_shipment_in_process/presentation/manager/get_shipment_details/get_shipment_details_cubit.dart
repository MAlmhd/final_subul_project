import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/get_shipment_details_entity/get_shipment_details_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_shipment_details_use_case/get_shipment_details_use_case.dart';

part 'get_shipment_details_state.dart';

class GetShipmentDetailsCubit extends Cubit<GetShipmentDetailsState> {
  final GetShipmentDetailsUseCase getShipmentDetailsUseCase;
  GetShipmentDetailsCubit(this.getShipmentDetailsUseCase)
    : super(GetShipmentDetailsInitial());
  Future<void> getShipmentDetails({required int idShipment}) async {
    emit(GetShipmentDetailsLoading());
    var data = await getShipmentDetailsUseCase.call(idShipment);
    data.fold(
      (failure) {
        emit(GetShipmentDetailsFailure(failure.message));
      },
      (success) {
        emit(GetShipmentDetailsSuccess(success));
      },
    );
  }
}
