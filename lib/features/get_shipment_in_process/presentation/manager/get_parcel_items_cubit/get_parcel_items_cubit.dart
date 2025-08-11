import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/get_parcel_items_entity/get_parcel_items_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_parcel_items_use_case/get_parcel_items_use_case.dart';

part 'get_parcel_items_state.dart';

class GetParcelItemsCubit extends Cubit<GetParcelItemsState> {
  final GetParcelItemsUseCase getParcelItemsUseCase;
  GetParcelItemsCubit(this.getParcelItemsUseCase)
    : super(GetParcelItemsInitial());

  Future<void> getParcelItems({required int id}) async {
    emit(GetParcelItemsLoading());
    var data = await getParcelItemsUseCase.call(id);
    data.fold(
      (failure) {
        emit(GetParcelItemsFailure(failure.message));
      },
      (success) {
        emit(GetParcelItemsSuccess(success));
      },
    );
  }
}
