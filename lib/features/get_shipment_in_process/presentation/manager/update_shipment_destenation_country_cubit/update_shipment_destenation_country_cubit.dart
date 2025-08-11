import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_destenation_country_entity/update_destenation_country_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/update_shipment_destenation_country_use_case/update_shipment_destenation_country_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/update_shipment_origin_country_use_case/update_shipment_origin_use_case.dart';

part 'update_shipment_destenation_country_state.dart';

class UpdateShipmentDestenationCountryCubit
    extends Cubit<UpdateShipmentDestenationCountryState> {
  UpdateShipmentDestenationCountryCubit(
    this.updateShipmentDestenationCountryUseCase,
  ) : super(UpdateShipmentDestenationCountryInitial());
  final UpdateShipmentDestenationCountryUseCase
  updateShipmentDestenationCountryUseCase;

  Future<void> updateCountry({
    required int idShipment,
    required int idCountry,
  }) async {
    emit(UpdateShipmentDestenationCountryLoading());
    UpdateCountryParam updateCountryParam = UpdateCountryParam(
      idShipment: idShipment,
      idCountry: idCountry,
    );
    var data = await updateShipmentDestenationCountryUseCase.call(
      updateCountryParam,
    );

    data.fold(
      (failure) {
        emit(UpdateShipmentDestenationCountryFailure(failure.message));
      },
      (success) {
        emit(UpdateShipmentDestenationCountrySuccess(success));
      },
    );
  }
}
