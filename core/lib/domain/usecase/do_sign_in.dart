import 'package:core/domain/repositories/auth_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoSignIn {
  final AuthRepository authRepository;

  DoSignIn(this.authRepository);

  Future<Either<Failure, User?>> execute(String email, String password){
    return authRepository.doSignIn(email, password);
  }
}