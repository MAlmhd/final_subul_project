import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// auth_cubit.dart
class AuthCubit extends Cubit<AuthState> {
  final AuthLocalDataSource authLocalDataSource;

  AuthCubit(this.authLocalDataSource) : super(AuthInitial());

  Future<void> logout() async {
    await authLocalDataSource.clearToken();
    emit(AuthLoggedOut()); // 🔹 أعطي إشارة أن المستخدم خرج
  }
}

// auth_state.dart
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoggedOut extends AuthState {}
