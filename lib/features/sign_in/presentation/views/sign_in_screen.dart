import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:final_subul_project/features/sign_in/presentation/manager/sign_in_cubit/sign_in_cubit.dart';
import 'package:final_subul_project/features/sign_in/presentation/views/widgets/sign_in_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SignInCubit(sl<SignInUseCase>()),
        child: const SignInBody(),
      ),
    );
  }
}
