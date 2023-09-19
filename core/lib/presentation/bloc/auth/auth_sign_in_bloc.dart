import 'package:core/domain/usecase/do_sign_in.dart';
import 'package:core/presentation/bloc/auth/auth_event.dart';
import 'package:core/presentation/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthSignInBloc extends Bloc<AuthEvent, AuthState>{
  final DoSignIn _doSignIn;

  AuthSignInBloc(this._doSignIn): super(InitialAuthState()){
    on<SignInEvent>((event, emit) async {
      emit(LoadingAuthState());
      final result = await _doSignIn.execute(event.email, event.password);

      result.fold((failue) {
        emit(UnAuthenticatedState(failue.message));
      }, (data) {
        emit(AuthenticatedState("Login Successfully"));
      });
    });
  }
}