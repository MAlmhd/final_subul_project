import 'package:equatable/equatable.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/get_deliverable_shipments_entity/get_deliverable_shipments_entity.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/use_case/get_deliverable_shipments_use_case/get_deliverable_shipments_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_deliverable_shipments_state.dart';

class GetDeliverableShipmentsCubit extends Cubit<GetDeliverableShipmentsState> {
  final GetDeliverableShipmentsUseCase getDeliverableShipmentsUseCase;
  GetDeliverableShipmentsCubit(this.getDeliverableShipmentsUseCase)
    : super(GetDeliverableShipmentsInitial());

  Future<void> getDeliverableShipments() async {
    emit(GetDeliverableShipmentsLoading());
    var data = await getDeliverableShipmentsUseCase.call();
    data.fold(
      (failure) {
        emit(GetDeliverableShipmentsFailure(failure.message));
      },
      (success) {
        emit(GetDeliverableShipmentsSuccess(success));
      },
    );
  }
}
