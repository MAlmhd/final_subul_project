import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/driver_entity/driver_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_drivers_use_case/get_drivers_use_case.dart';

part 'get_drivers_state.dart';

class GetDriversCubit extends Cubit<GetDriversState> {
  final GetDriversUseCase getDriversUseCase;
  GetDriversCubit(this.getDriversUseCase) : super(GetDriversInitial());

  Future<void> getDrivers() async {
    emit(GetDriversLoading());
    var data = await getDriversUseCase.call();
    data.fold(
      (failure) {
        emit(GetDriversFailure(failure.message));
      },
      (success) {
        emit(GetDriversSuccess(success));
      },
    );
  }
}
