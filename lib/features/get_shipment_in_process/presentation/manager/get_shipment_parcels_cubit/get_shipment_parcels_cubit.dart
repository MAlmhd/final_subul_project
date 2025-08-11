import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/specific_parcels_of_shipment_entity/specific_parcels_of_shipment_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_shipment_parcels_use_case/get_shipment_parcels_use_case.dart';

part 'get_shipment_parcels_state.dart';

class GetShipmentParcelsCubit extends Cubit<GetShipmentParcelsState> {
  final GetShipmentParcelsUseCase getShipmentParcelsUseCase;
  GetShipmentParcelsCubit(this.getShipmentParcelsUseCase)
    : super(GetShipmentParcelsInitial());

  Future<void> getShipmentParcels({required int shipmentId}) async {
    emit(GetShipmentParcelsLoading());
    var data = await getShipmentParcelsUseCase.call(shipmentId);
    data.fold(
      (failure) {
        emit(GetShipmentParcelsFailure(failure.message));
      },
      (success) {
        emit(GetShipmentParcelsSuccess(success));
      },
    );
  }
}
