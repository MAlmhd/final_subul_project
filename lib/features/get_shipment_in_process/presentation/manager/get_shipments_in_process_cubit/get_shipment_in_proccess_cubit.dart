import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/shipment_in_process_entity/shipment_in_process_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_shipments_in_process_use_case/get_shipments_in_process_use_case.dart';

part 'get_shipment_in_proccess_state.dart';

class GetShipmentInProccessCubit extends Cubit<GetShipmentInProccessState> {
  final GetShipmentsInProcessUseCase getShipmentsInProcessUseCase;
  GetShipmentInProccessCubit(this.getShipmentsInProcessUseCase)
    : super(GetShipmentInProccessInitial());

  Future<void> getShipments() async {
    emit(GetShipmentInProccessLoading());

    var data = await getShipmentsInProcessUseCase.call();
    data.fold(
      (failure) {
        emit(GetShipmentInProccessFailure(failure.message));
      },
      (success) {
        emit(GetShipmentInProccessSuccess(success));
      },
    );
  }
}
