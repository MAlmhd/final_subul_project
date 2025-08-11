import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/get_all_parcels/domain/entities/parcel_entity/parcel_entity.dart';
import 'package:final_subul_project/features/get_all_parcels/domain/use_case/get_all_parcels_use_case/get_all_parcels_use_case.dart';

part 'get_all_parcels_state.dart';

class GetAllParcelsCubit extends Cubit<GetAllParcelsState> {
  GetAllParcelsCubit(this.getAllParcelsUseCase) : super(GetAllParcelsInitial());
  final GetAllParcelsUseCase getAllParcelsUseCase;

  Future<void> getAllParcels() async {
    emit(GetAllParcelsLoading());
    var data = await getAllParcelsUseCase.call();
    data.fold(
      (failure) {
        emit(GetAllParcelsFailure(failure.message));
      },
      (success) {
        emit(GetAllParcelsSuccess(success));
      },
    );
  }
}
