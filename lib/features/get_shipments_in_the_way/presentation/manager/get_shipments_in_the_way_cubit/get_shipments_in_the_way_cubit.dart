import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/shipment_in_the_way_entity/shipment_in_the_way_entity.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/use_case/get_shipments_in_the_way_use_case/get_shipments_in_the_way_use_case.dart';

part 'get_shipments_in_the_way_state.dart';

class GetShipmentsInTheWayCubit extends Cubit<GetShipmentsInTheWayState> {
  final GetShipmentsInTheWayUseCase getShipmentsInTheWayUseCase;
  GetShipmentsInTheWayCubit(this.getShipmentsInTheWayUseCase)
    : super(GetShipmentsInTheWayInitial());

  Future<void> getShipmentsInTheWay() async {
    emit(GetShipmentsInTheWayLoading());
    var data = await getShipmentsInTheWayUseCase.call();
    data.fold(
      (failure) {
        emit(GetShipmentsInTheWayFailure(failure.message));
      },
      (success) {
        emit(GetShipmentsInTheWaySuccess(success));
      },
    );
  }
}
