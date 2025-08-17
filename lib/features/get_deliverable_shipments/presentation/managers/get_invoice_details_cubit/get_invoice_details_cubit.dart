import 'package:equatable/equatable.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/get_invoice_details_entity/get_invoice_details_entity.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/use_case/get_invoice_details_use_case/get_invoice_details_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_invoice_details_state.dart';

class GetInvoiceDetailsCubit extends Cubit<GetInvoiceDetailsState> {
  final GetInvoiceDetailsUseCase getInvoiceDetailsUseCase;
  GetInvoiceDetailsCubit(this.getInvoiceDetailsUseCase)
    : super(GetInvoiceDetailsInitial());
  Future<void> getInvoiceDetails({required int shipmentId}) async {
    emit(GetInvoiceDetailsLoading());
    var data = await getInvoiceDetailsUseCase.call(shipmentId);
    data.fold(
      (failure) {
        emit(GetInvoiceDetailsFailure(failure.message));
      },
      (success) {
        emit(GetInvoiceDetailsSuccess(success));
      },
    );
  }
}
