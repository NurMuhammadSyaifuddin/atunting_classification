import 'package:core/data/datasource/firebase_datasource.dart';
import 'package:core/data/repositories/auth_repository_impl.dart';
import 'package:core/data/repositories/news_repository_impl.dart';
import 'package:core/domain/repositories/auth_repository.dart';
import 'package:core/domain/repositories/news_repository.dart';
import 'package:core/domain/usecase/do_sign_in.dart';
import 'package:core/domain/usecase/do_sign_up.dart';
import 'package:core/domain/usecase/get_result_history.dart';
import 'package:core/domain/usecase/do_sign_up_with_google.dart';
import 'package:core/domain/usecase/get_inspections.dart';
import 'package:core/domain/usecase/get_news_list.dart';
import 'package:core/presentation/bloc/auth/auth_bloc.dart';
import 'package:core/presentation/bloc/auth/auth_with_google_bloc.dart';
import 'package:core/presentation/bloc/auth/auth_sign_in_bloc.dart';
import 'package:core/presentation/bloc/result_history/get_result_history_bloc.dart';
import 'package:core/presentation/bloc/news/get_list_bloc.dart';
import 'package:core/presentation/bloc/inspection/inspection_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final locator = GetIt.instance;

void init(){
  locator.registerFactory(() => AuthBloc(locator()));
  locator.registerFactory(() => AuthWithGoogleBloc(locator()));
  locator.registerFactory(() => AuthSignInBloc(locator()));
  locator.registerFactory(() => GetListBloc(locator()));
  locator.registerFactory(() => GetInspectionBloc(locator()));
  locator.registerFactory(() => GetResultHistoryBloc(locator()));

  locator.registerLazySingleton(() => DoSignUp(locator()));
  locator.registerLazySingleton(() => DoSignUpWithGoogle(locator()));
  locator.registerLazySingleton(() => DoSignIn(locator()));
  locator.registerLazySingleton(() => GetNewsList(locator()));
  locator.registerLazySingleton(() => GetInspection(locator()));
  locator.registerLazySingleton(() => GetResultHistory(locator()));

  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(locator(), locator()));
  locator.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(locator(), locator()));

  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseDataSource());
  locator.registerLazySingleton(() => GoogleSignIn());
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
}