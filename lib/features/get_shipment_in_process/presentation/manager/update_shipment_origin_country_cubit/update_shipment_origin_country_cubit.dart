import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_origin_country_entity/update_origin_country_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/update_shipment_origin_country_use_case/update_shipment_origin_use_case.dart';

part 'update_shipment_origin_country_state.dart';

class UpdateShipmentOriginCountryCubit
    extends Cubit<UpdateShipmentOriginCountryState> {
  final UpdateShipmentOriginUseCase updateShipmentOriginUseCase;
  UpdateShipmentOriginCountryCubit(this.updateShipmentOriginUseCase)
    : super(UpdateShipmentOriginCountryInitial());

  Future<void> updateCountry({
    required int idCountry,
    required int idShipment,
  }) async {
    emit(UpdateShipmentOriginCountryLoading());

    UpdateCountryParam updateCountryParam = UpdateCountryParam(
      idShipment: idShipment,
      idCountry: idCountry,
    );
    var data = await updateShipmentOriginUseCase.call(updateCountryParam);
    data.fold(
      (failure) {
        emit(UpdateShipmentOriginCountryFailure(failure.message));
      },
      (success) {
        emit(UpdateShipmentOriginCountrySuccess(success));
      },
    );
  }
}
