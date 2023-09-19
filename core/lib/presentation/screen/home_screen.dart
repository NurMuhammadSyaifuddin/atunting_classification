
import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/news/get_list_bloc.dart';
import 'package:core/presentation/bloc/news/news_event.dart';
import 'package:core/presentation/bloc/news/news_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../notifier/news_model.dart';
import '../../style/colors.dart';
import 'news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetListBloc>(context).add(GetNewsListEvent());
  }

  Future<void> _refreshData() async {
    BlocProvider.of<GetListBloc>(context).add(GetNewsListEvent());
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: firstBlue,
      statusBarBrightness: Brightness.light,
    ));

    final auth = FirebaseAuth.instance;
    final model = Provider.of<NewsModel>(context);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                        style: DefaultTextStyle.of(context).style,
                                        children:  [
                                          const TextSpan(
                                              text: 'Welcome\nBack, ',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  color: Colors.grey)),
                                          TextSpan(
                                              text: auth.currentUser?.displayName ?? auth.currentUser?.email,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: kDavysGrey,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Expanded(
                                  child: Text(
                                    '\u{1F44B}',
                                    style: TextStyle(fontSize: 36),
                                  ),
                                )
                              ],
                            )),
                        auth.currentUser?.photoURL != null ?
                        ClipRRect(
                          borderRadius: BorderRadius.circular(48),
                          child: Image.network(auth.currentUser!.photoURL.toString(), fit: BoxFit.cover, width: 48, height: 48,),
                        ) :
                        const Icon(Icons.person)
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'News',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: kRichBlack),
                        ),
                        Text(
                          'See All',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: kMikadoYellow),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<GetListBloc, NewsState>(
                              builder: (context, state) {
                                if (state is LoadingNewsState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is LoadedNewsState) {
                                  final data = state.listNews;
                                  return Column(
                                    children: [
                                      CarouselSlider(
                                        options: CarouselOptions(
                                          onPageChanged: (index, reason) {
                                            model.setCurrentPage(index);
                                          },
                                          autoPlay: true,
                                          autoPlayInterval: const Duration(seconds: 5),
                                          autoPlayAnimationDuration:
                                          const Duration(milliseconds: 1000),
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          pauseAutoPlayOnTouch: true,
                                          enlargeCenterPage: true,
                                          viewportFraction: 0.8,
                                        ),
                                        items: data.map((item) {
                                          return GestureDetector(
                                            onTap: (){
                                              Navigator.pushNamed(context, NEWS_DETAIL, arguments: item);
                                            },
                                            child: NewsScreen(
                                              title: item.title.toString(),
                                              content: item.content.toString(),
                                              author: item.author.toString(),
                                              imageUrl: item.imageUrl.toString(),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: map<Widget>(data, (index, url) {
                                          return Container(
                                            width:
                                            model.currentPage == index ? 30 : 10.0,
                                            height: 10.0,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: model.currentPage == index
                                                    ? firstBlue
                                                    : firstBlue.withOpacity(0.3)),
                                          );
                                        }),
                                      )
                                    ],
                                  );
                                } else if (state is ErrorNewsState) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(state.message),
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 2),
                                  ));
                                  return Container();
                                }
                                return Container();
                              }),
                          Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Cek Stunting',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: kRichBlack),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, CHECK_STUNTING);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Colors.green)),
                                    child:  const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Cek",
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
                                          Icons.logout,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}
