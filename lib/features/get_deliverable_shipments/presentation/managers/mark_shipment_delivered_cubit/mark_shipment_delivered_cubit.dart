import 'package:equatable/equatable.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/mark_shipment_delivered_entity/mark_shipment_delivered_entity.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/use_case/mark_shipment_delivered_use_case/mark_shipment_delivered_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'mark_shipment_delivered_state.dart';

class MarkShipmentDeliveredCubit extends Cubit<MarkShipmentDeliveredState> {
  final MarkShipmentDeliveredUseCase markShipmentDeliveredUseCase;
  MarkShipmentDeliveredCubit(this.markShipmentDeliveredUseCase)
    : super(MarkShipmentDeliveredInitial());

  Future<void> markShipmentDelivered({
    required int shipmentId,
    required XFile deliveryPhoto,
  }) async {
    emit(MarkShipmentDeliveredLoading());
    MarkShipmentDeliveredParams markShipmentDeliveredParams =
        MarkShipmentDeliveredParams(
          shipmentId: shipmentId,
          deliveryPhoto: deliveryPhoto,
        );
    var data = await markShipmentDeliveredUseCase.call(
      markShipmentDeliveredParams,
    );

    data.fold(
      (failure) {
        emit(MarkShipmentDeliveredFailure(failure.message));
      },
      (success) {
        emit(MarkShipmentDeliveredSuccess(success));
      },
    );
  }
}
