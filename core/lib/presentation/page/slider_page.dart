import 'package:core/core.dart';
import 'package:core/presentation/bloc/auth/auth_event.dart';
import 'package:core/presentation/bloc/auth/auth_sign_in_bloc.dart';
import 'package:core/presentation/bloc/auth/auth_state.dart';
import 'package:core/presentation/bloc/auth/auth_with_google_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../notifier/page_model.dart';
import '../../style/colors.dart';
import '../screen/sign_up_popup.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<StatefulWidget> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (auth.currentUser != null) {
        Navigator.pushReplacementNamed(context, HOME_PAGE);
      }
    });
  }

  final int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final pageModel = Provider.of<PageModel>(context, listen: false);
    final PageController pageController =
    PageController(initialPage: pageModel.currentPage);
    return Consumer<PageModel>(
        builder: (context, model, _) =>
            Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [thirdBlue, fourthBlue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight)),
                    child: SafeArea(
                        child: PageView(
                            controller: pageController,
                            onPageChanged: (int page) {
                              model.setCurrentPage(page);
                            },
                            children: [
                              page1(context, pageController),
                              page2(context, pageController),
                              page3(context)
                            ])),
                  ),
                  Positioned(
                      bottom: 32,
                      left: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 3,
                          effect: const WormEffect(
                              activeDotColor: kMikadoYellow),
                          onDotClicked: (index) {
                            pageController.animateToPage(index,
                                duration:
                                const Duration(milliseconds: 1000),
                                curve: Curves.ease);
                          },
                        ),
                      ))
                ],
              ),
            ));
  }

  Widget page1(BuildContext context, PageController pageController) {
    return Consumer<PageModel>(
        builder: (context, model, _) =>
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Image.asset(
                    "assets/logo_doctor_wanita.png",
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    'Stunting',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 28),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Stunting adalah kondisi gagal tumbuh pada anak yang disebabkan oleh kekurangan gizi kronis, terutama pada periode 1.000 hari pertama kehidupan sejak konsepsi hingga usia dua tahun. Kondisi ini ditandai dengan pertumbuhan tubuh yang terhambat, yaitu tinggi badan anak yang lebih pendek dari tinggi badan normal yang seharusnya sebanding dengan usianya.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white70,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      model.setCurrentPage(_currentPage + 1);
                      pageController.animateToPage(model.currentPage,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.ease);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.green)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget page2(BuildContext context, PageController pageController) {
    return Consumer<PageModel>(
        builder: (context, model, _) =>
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Image.asset(
                        "assets/logo_doctor_pria.png",
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Text(
                        'Ayo Periksa Mandiri!',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 28),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Lakukan pemeriksaan mandiri terhadap kondisimu dan dapatkan hasil diagnosis tingkatan Stunting yang kamu derita, serta lakukan saran yang diberikan langsung dari pakarnya',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white70,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          pageController.animateToPage(model.currentPage + 1,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.ease);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Log In",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }

  Widget page3(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return MultiBlocListener(listeners: [
      BlocListener<AuthWithGoogleBloc, AuthState>(listener: (context, state) {
        if (state is LoadingAuthState) {
          showDialog(context: context,
              barrierDismissible: false,
              builder: (context) {
                return const Dialog(
                  child: Padding(padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16,),
                        Text('Loading...', style: TextStyle(fontSize: 16,
                            fontFamily: 'Poppins'),)
                      ],
                    ),),
                );
              });
        } else if (state is AuthenticatedState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.pushReplacementNamed(context, HOME_PAGE);
        } else if (state is UnAuthenticatedState) {
          Navigator.pop(context);
          print(state.message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }),
      BlocListener<AuthSignInBloc, AuthState>(listener: (context, state) {
        if (state is LoadingAuthState) {
          showDialog(context: context,
              barrierDismissible: false,
              builder: (context) {
                return const Dialog(
                  child: Padding(padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16,),
                        Text('Loading...', style: TextStyle(fontSize: 16,
                            fontFamily: 'Poppins'),)
                      ],
                    ),),
                );
              });
        } else if (state is AuthenticatedState) {
          Navigator.pop(context);
          if (FirebaseAuth.instance.currentUser!.emailVerified){
            Navigator.pushReplacementNamed(context, HOME_PAGE);
          }else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Email is not verified, please check your email", style: TextStyle(
                    fontFamily: 'Poppins'
                ),),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
              ),
            );
          }

        } else if (state is UnAuthenticatedState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      })
    ],
        child: BlocBuilder<AuthWithGoogleBloc, AuthState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context, builder: (context) {
                                    return const SignUpPopUp();
                                  });
                                },
                                child: const Text('Sign Up',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: kMikadoYellow,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Image.asset(
                              'assets/logo_signin.png',
                              width: 200,
                              height: 200,
                            ),
                            const SizedBox(
                              height: 16,
                            ),

                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 28),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextField(
                              controller: emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                filled: false,
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white70,
                                ),
                                prefixIcon: Icon(
                                  Icons.email_rounded,
                                  color: Colors.white,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white)),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextField(
                              controller: passwordController,
                              style: const TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white70,
                                ),
                                prefixIcon: Icon(
                                  Icons.key_outlined,
                                  color: Colors.white,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white)),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 24,),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: ElevatedButton(
                                onPressed: () {
                                    BlocProvider.of<AuthSignInBloc>(context)
                                        .add(SignInEvent(emailController.text,
                                        passwordController.text));
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(Colors.green)),
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16,),
                            const Text('Atau',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                              ),),
                            const SizedBox(height: 16,),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<AuthWithGoogleBloc>(context)
                                        .add(SignUpWithGoogleEvent());
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/logo_google.png', width: 24,
                                        height: 24,),
                                      const SizedBox(width: 12,),
                                      const Text(
                                        "Google",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: kGrey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
