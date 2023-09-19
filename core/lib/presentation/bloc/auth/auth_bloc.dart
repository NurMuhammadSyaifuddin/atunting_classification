import 'package:core/domain/usecase/do_sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/presentation/bloc/auth/auth_event.dart';
import 'package:core/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final DoSignUp _doSignUp;

  AuthBloc(this._doSignUp) : super(InitialAuthState()) {
    on<SignUpEvent>((event, emit) async {
      emit(LoadingAuthState());
      final result = await _doSignUp.execute(event.email, event.password);

      result.fold((failure) {
        emit(UnAuthenticatedState(failure.message));
      }, (data) {
        emit(AuthenticatedState('Akun ${data?.displayName} berhasil dibuat'));
      });
    });


  }

}