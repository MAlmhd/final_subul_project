import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/sign_in/domain/entites/sign_in_entity.dart';

abstract class SignInRepo {
  Future<Either<Failure, SignInEntity>> signIn({required String email,required String password});
}
