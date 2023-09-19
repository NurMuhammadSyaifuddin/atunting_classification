import 'package:core/utils/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class DoSignUpWithGoogle {
  final AuthRepository authRepository;

  DoSignUpWithGoogle(this.authRepository);

  Future<Either<Failure, User?>> execute(){
    return authRepository.getUser();
  }
}