import 'package:equatable/equatable.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/supplier_entity/supplier_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/use_case/get_suppliers_use_case/get_suppliers_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_suppliers_state.dart';

class GetSuppliersCubit extends Cubit<GetSuppliersState> {
  final GetSuppliersUseCase getSuppliersUseCase;
  GetSuppliersCubit(this.getSuppliersUseCase) : super(GetSuppliersInitial());

  Future<void> getSuppliers() async {
    emit(GetSuppliersLoading());
    var data = await getSuppliersUseCase.call();
    data.fold(
      (failure) {
        emit(GetSuppliersFailures(failure.message));
      },
      (success) {
        emit(GetSuppliersSuccess(success));
      },
    );
  }
}
