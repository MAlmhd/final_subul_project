import 'package:equatable/equatable.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/flight_entity/flight_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_flights_use_case/get_flights_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_flights_state.dart';

class GetFlightsCubit extends Cubit<GetFlightsState> {
  final GetFlightsUseCase getFlightsUseCase;
  GetFlightsCubit(this.getFlightsUseCase) : super(GetFlightsInitial());

  Future<void> getFlights() async {
    emit(GetFlightsLoading());
    var data = await getFlightsUseCase.call();
    data.fold(
      (failure) {
        emit(GetFlightsFailure(failure.message));
      },
      (success) {
        emit(GetFlightsSuccess(success));
      },
    );
  }
}
