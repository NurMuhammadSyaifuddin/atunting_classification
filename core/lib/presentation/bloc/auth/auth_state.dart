import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable{}

class InitialAuthState extends AuthState{
  @override
  List<Object?> get props => [];
}
class LoadingAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}
class AuthenticatedState extends AuthState{
  String message;

  AuthenticatedState(this.message);

  @override
  List<Object?> get props => [message];
}
class UnAuthenticatedState extends AuthState{
  String message;

  UnAuthenticatedState(this.message);

  @override
  List<Object?> get props => [message];
}