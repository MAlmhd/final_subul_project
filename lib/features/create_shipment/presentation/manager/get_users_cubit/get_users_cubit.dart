import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/user_entity/user_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/use_case/get_users_use_case/get_user_use_case.dart';

part 'get_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  GetUsersCubit(this.getUserUseCase) : super(GetUsersInitial());
  final GetUserUseCase getUserUseCase;

  Future<void> getUser() async {
    emit(GetUsersLoading());
    var data = await getUserUseCase.call();
    data.fold(
      (failure) {
        emit(GetUsersFailure(failure.message));
      },
      (success) {
        emit(GetUsersSuccess(success));
      },
    );
  }
}
