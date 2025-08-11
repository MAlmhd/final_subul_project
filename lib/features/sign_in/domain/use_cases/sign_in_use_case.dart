import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/sign_in/domain/entites/sign_in_entity.dart';
import 'package:final_subul_project/features/sign_in/domain/repos/sign_in_repo.dart';

class SignInUseCase extends UseCase<SignInEntity, SignInParams> {
  final SignInRepo signInRepo;

  SignInUseCase(this.signInRepo);

  @override
  Future<Either<Failure, SignInEntity>> call([SignInParams? params]) async {
   
    return await signInRepo.signIn(
      email: params!.email,
      password: params.password,
    );
  }
}




class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}
