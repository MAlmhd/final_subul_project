import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/create_shipment_entity/create_shipment_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/use_case/create_shipment_use_case/create_shipment_use_case.dart';

part 'create_shipment_state.dart';

class CreateShipmentCubit extends Cubit<CreateShipmentState> {
  CreateShipmentCubit(this.createShipmentUseCase)
    : super(CreateShipmentInitial());
  final CreateShipmentUseCase createShipmentUseCase;

  Future<void> createShipment({
    required String type,
    required int customerId,
    required int supplierId,
    required String declaredParcelsCount,
    required String notes,
    required int originCountryId,
    required int destenationCountryId,
  }) async {
    emit(CreateShipmentLoading());
    CreateShipmentParams createShipmentParams = CreateShipmentParams(
      originCountryId: originCountryId,
      destenationCountryId: destenationCountryId,
      type: type,
      customerId: customerId,
     supplierId: supplierId,
      declaredParcelsCount: declaredParcelsCount,
      notes: notes,
    );

    var data = await createShipmentUseCase.call(createShipmentParams);
    data.fold(
      (failure) {
        emit(CreateShipmentFailure(failure.message));
      },
      (success) {
        emit(CreateShipmentSuccess(success));
      },
    );
  }
}
