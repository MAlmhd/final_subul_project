

import 'package:equatable/equatable.dart';
import 'package:final_subul_project/features/sign_in/domain/entites/sign_in_entity.dart';
import 'package:final_subul_project/features/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.signInUseCase) : super(SignInInitial());
  final SignInUseCase signInUseCase;

  Future<void> signIn({required String email, required String password}) async {
    emit(SignInLoadingState());
    
    
    SignInParams signInParams = SignInParams(email: email, password: password);
    var result = await signInUseCase.call(signInParams);
    result.fold(
      (failure) {
        emit(SignInFailureState(failure.message));
      },
      (success) {
        emit(SignInSuccessState(success));
      },
    );
  }
}
