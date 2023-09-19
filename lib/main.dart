import 'dart:io';
import 'package:core/models/news.dart';
import 'package:core/models/result_history.dart';
import 'package:core/notifier/answer_model.dart';
import 'package:core/notifier/news_model.dart';
import 'package:core/notifier/page_model.dart';
import 'package:core/notifier/score_model.dart';
import 'package:core/notifier/result_history_provider.dart';
import 'package:core/presentation/bloc/auth/auth_bloc.dart';
import 'package:core/presentation/bloc/auth/auth_sign_in_bloc.dart';
import 'package:core/presentation/bloc/auth/auth_with_google_bloc.dart';
import 'package:core/presentation/bloc/inspection/inspection_bloc.dart';
import 'package:core/presentation/bloc/news/get_list_bloc.dart';
import 'package:core/presentation/bloc/result_history/get_result_history_bloc.dart';
import 'package:core/presentation/page/home_page.dart';
import 'package:core/presentation/page/question_page.dart';
import 'package:core/presentation/page/slider_page.dart';
import 'package:core/presentation/page/result_page.dart';
import 'package:core/presentation/page/news_detail.dart';
import 'package:core/style/colors.dart';
import 'package:core/utils/route.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stunting_classification/injection.dart' as di;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SecurityContext(withTrustedRoots: false);
  await Firebase.initializeApp();
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      BlocProvider(create: (context) => di.locator<AuthBloc>()),
      BlocProvider(create: (context) => di.locator<AuthSignInBloc>()),
      BlocProvider(create: (context) => di.locator<AuthWithGoogleBloc>()),
      BlocProvider(create: (context) => di.locator<GetListBloc>()),
      BlocProvider(create: (context) => di.locator<GetInspectionBloc>()),
      BlocProvider(create: (context) => di.locator<GetResultHistoryBloc>()),
      ChangeNotifierProvider(create: (context) => PageModel()),
      ChangeNotifierProvider(create: (context) => NewsModel()),
      ChangeNotifierProvider(create: (context) => AnswerModel()),
      ChangeNotifierProvider(create: (context) => ScoreModel()),
      ChangeNotifierProvider(create: (context) => ResultHistoryProvider())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      title: 'Stunting Classification',
      theme: ThemeData.light().copyWith(colorScheme: kColorScheme, primaryColor: firstBlue),
      home: const SliderPage(),
      onGenerateRoute: (RouteSettings settings){
        switch(settings.name){
          case '/slider':
            return MaterialPageRoute(builder: (_) => const SliderPage());
          case HOME_PAGE:
            return MaterialPageRoute(builder: (_) => const HomePage());
          case CHECK_STUNTING:
            return MaterialPageRoute(builder: (_) => const QuestionPage());
          case NEWS_DETAIL:
            final news = settings.arguments as News;
            return MaterialPageRoute(builder: (_) => NewsDetail(news), settings: settings);
          case RESULT_PAGE:
            final result = settings.arguments;
            return MaterialPageRoute(builder: (_) => ResultPage(result), settings: settings);
        }
        return MaterialPageRoute(builder: (_) => const SliderPage());
      },
    ),);
  }
}
