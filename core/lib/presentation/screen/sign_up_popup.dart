import 'package:core/presentation/bloc/auth/auth_bloc.dart';
import 'package:core/presentation/bloc/auth/auth_event.dart';
import 'package:core/presentation/bloc/auth/auth_state.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPopUp extends StatefulWidget {
  const SignUpPopUp({super.key});

  @override
  State<SignUpPopUp> createState() => _SignUpPopUpState();
}

class _SignUpPopUpState extends State<SignUpPopUp> {
  final TextEditingController _emailController = TextEditingController();
   final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<AuthBloc, AuthState>(listener: (context, state){
      if (state is AuthenticatedState) {
        Navigator.pop(context); // Menutup pop-up

      } else if (state is UnAuthenticatedState) {
        Navigator.pop(context); // Menutup pop-up
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );

      }
    },
    child: Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _emailController,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
              ),
              decoration: const InputDecoration(
                labelText: 'Email',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                ),
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
              ),
              decoration: const InputDecoration(
                labelText: 'Password',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                ),
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is LoadingAuthState) {
              // Menampilkan progress bar saat loading
              return const CircularProgressIndicator();
            } else {
              // Menampilkan tombol saat tidak sedang loading
              return ElevatedButton(
                onPressed: () {
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  if (isValidEmail(email)) {
                    context.read<AuthBloc>().add(SignUpEvent(email: email, password: password));
                  } else {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invalid email format'),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }

                },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Colors.green),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            }
          },
        ),
          ],
        ),
      ),
    ),);
  }
}
