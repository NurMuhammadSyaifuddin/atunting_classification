import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignUpEvent extends AuthEvent{
  final String email;
  final String password;

  const SignUpEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpWithGoogleEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  String email;
  String password;

  SignInEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}