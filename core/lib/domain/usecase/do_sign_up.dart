import 'package:core/domain/repositories/auth_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoSignUp {
  final AuthRepository repository;

  DoSignUp(this.repository);

  Future<Either<Failure, User?>> execute(String? email, String? password){
    return repository.doSignUp(email, password);
  }
}