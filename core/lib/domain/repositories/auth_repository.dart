import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, User?>> doSignUp(String? email, String? password);
  Future<Either<Failure, User?>> doSignIn(String? email, String? password);
  Future<Either<Failure, User?>> getUser();
}