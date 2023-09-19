import 'package:core/domain/usecase/do_sign_up_with_google.dart';
import 'package:core/presentation/bloc/auth/auth_event.dart';
import 'package:core/presentation/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWithGoogleBloc extends Bloc<AuthEvent, AuthState> {
  final DoSignUpWithGoogle _doSignUpWithGoogle;

  AuthWithGoogleBloc(this._doSignUpWithGoogle) : super(InitialAuthState()) {
    on<SignUpWithGoogleEvent>((event, emit) async {
      emit(LoadingAuthState());
      final result = await _doSignUpWithGoogle.execute();

      result.fold((failure) {
        emit(UnAuthenticatedState(failure.message));
      }, (data) {
        emit(AuthenticatedState('Akun ${data?.displayName} berhasil dibuat'));
      });
    });
  }
}