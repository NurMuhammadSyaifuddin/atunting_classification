import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:core/domain/repositories/auth_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl(this._firebaseAuth, this._googleSignIn);

  @override
  Future<Either<Failure, User?>> doSignUp(String? email, String? password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email!, password: password!);
      await _firebaseAuth.currentUser!.sendEmailVerification();
      return Right(userCredential.user);
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.message));
    } on FirebaseAuthException catch (e){
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getUser() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

      return Right(userCredential.user);
    } on SocketException catch (e){
      return Left(ConnectionFailure(e.message));
    } on FirebaseAuthException catch (e){
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> doSignIn(String? email, String? password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email!, password: password!);
      return Right(userCredential.user);
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.message));
    } on FirebaseAuthException catch (e){
      return Left(ServerFailure(e.message.toString()));
    }
  }

}