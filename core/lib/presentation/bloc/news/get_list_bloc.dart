import 'package:core/domain/usecase/get_news_list.dart';
import 'package:core/presentation/bloc/news/news_event.dart';
import 'package:core/presentation/bloc/news/news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetListBloc extends Bloc<NewsEvent, NewsState>{
  final GetNewsList _getNewsList;

  GetListBloc(this._getNewsList): super(InitialNewsState()){
    on<GetNewsListEvent>((event, emit) async {
      emit(LoadingNewsState());
      final result = await _getNewsList.execute();

      result.fold((failure) {
        emit(ErrorNewsState(failure.message));
      }, (data) {
        emit(LoadedNewsState(data));
      });
    });
  }
}