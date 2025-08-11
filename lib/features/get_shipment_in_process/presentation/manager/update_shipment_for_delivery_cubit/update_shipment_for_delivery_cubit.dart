import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_shipment_for_delivery_entity/update_shipment_for_delivery_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/update_shipment_for_delivery_use_case/update_shipment_for_delivery_use_case.dart';

part 'update_shipment_for_delivery_state.dart';

class UpdateShipmentForDeliveryCubit
    extends Cubit<UpdateShipmentForDeliveryState> {
  final UpdateShipmentForDeliveryUseCase updateShipmentForDeliveryUseCase;
  UpdateShipmentForDeliveryCubit(this.updateShipmentForDeliveryUseCase)
    : super(UpdateShipmentForDeliveryInitial());

  Future<void> updateShipment({
    required XFile photo,
    required int idDelivery,
    required int actualParcelsCount,
    required int idShipment,
  }) async {
    emit(UpdateShipmentForDeliveryLoading());
    UpdateShipmentForDeliveryParams updateShipmentForDeliveryParams =
        UpdateShipmentForDeliveryParams(
          idDelivery: idDelivery,
          idShipment: idShipment,
          actualParcelsCount: actualParcelsCount,
          photo: photo,
        );
    var data = await updateShipmentForDeliveryUseCase.call(
      updateShipmentForDeliveryParams,
    );
    data.fold(
      (failure) {
        emit(UpdateShipmentForDeliveryFailure(failure.message));
      },
      (success) {
        emit(UpdateShipmentForDeliverySuccess(success));
      },
    );
  }
}
