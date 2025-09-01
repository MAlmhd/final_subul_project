import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/create_shipment_entity/create_shipment_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/use_case/create_shipment_use_case/create_shipment_use_case.dart';
import 'package:image_picker/image_picker.dart';

part 'create_shipment_state.dart';

class CreateShipmentCubit extends Cubit<CreateShipmentState> {
  CreateShipmentCubit(this.createShipmentUseCase)
    : super(CreateShipmentInitial());
  final CreateShipmentUseCase createShipmentUseCase;

  Future<void> createShipment({
    required String type,
    required int customerId,
   required List<int> supplierIds,
     String? declaredParcelsCount,
    required String notes,
    required int originCountryId,
    required int destenationCountryId,
    required XFile invoiceFile,
  }) async {
    emit(CreateShipmentLoading());
    CreateShipmentParams createShipmentParams = CreateShipmentParams(
      originCountryId: originCountryId,
      destenationCountryId: destenationCountryId,
      type: type,
      customerId: customerId,
     supplierIds: supplierIds,
      declaredParcelsCount: declaredParcelsCount,
      notes: notes, invoiceFile: invoiceFile,
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
