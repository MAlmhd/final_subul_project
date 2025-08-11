import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/allowed_content_entity/allowed_content_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_allowed_content_use_case/get_allowed_content_use_case.dart';

part 'get_allowed_content_state.dart';

class GetAllowedContentCubit extends Cubit<GetAllowedContentState> {
  final GetAllowedContentUseCase getAllowedContentUseCase;
  GetAllowedContentCubit(this.getAllowedContentUseCase)
    : super(GetAllowedContentInitial());

  Future<void> getContents() async {
    emit(GetAllowedContentLoading());
    var data = await getAllowedContentUseCase.call();
    data.fold(
      (failure) {
        emit(GetAllowedContentFailure(failure.message));
      },
      (success) {
        emit(GetAllowedContentSuccess(success));
      },
    );
  }
}
