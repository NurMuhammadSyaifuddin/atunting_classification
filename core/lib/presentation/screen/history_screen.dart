import 'package:core/core.dart';
import 'package:core/presentation/bloc/result_history/result_history_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/result_history.dart';
import '../../style/colors.dart';
import '../bloc/result_history/get_result_history_bloc.dart';
import '../bloc/result_history/result_history_event.dart';
import 'history_item.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetResultHistoryBloc>(context).add(GetResultHistoryEvent(auth.currentUser!.email.toString()));
  }

  Future<void> _refreshData() async {
    BlocProvider.of<GetResultHistoryBloc>(context).add(GetResultHistoryEvent(auth.currentUser!.email.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<GetResultHistoryBloc, ResultHistoryState>(builder: (context, state){
        if (state is LoadingResultHistoryState){
          return const Center(child: CircularProgressIndicator(),);
        } else if (state is LoadedResultHistoryState){
          final data = state.resultHistory;
          if (data.isNotEmpty){

            int compareByScore(ResultHistory a, ResultHistory b) {
              return b.date.compareTo(a.date);
            }
            data.sort(compareByScore);

            return Column(
              children: [
                // Padding(padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                //   child: TextField(
                //     style: const TextStyle(fontFamily: 'Poppins', color: kRichBlack),
                //     decoration: InputDecoration(
                //         hintText: 'Search',
                //         hintStyle:
                //         TextStyle(fontFamily: 'Poppins', color: Colors.grey[400]),
                //         prefixIcon: const Icon(
                //           Icons.search,
                //           color: kGrey,
                //         ),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(8),
                //             borderSide: BorderSide.none),
                //         filled: true,
                //         fillColor: Colors.grey[200],
                //         contentPadding:
                //         const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
                //   ),),
                Expanded(
                    child: RefreshIndicator(onRefresh: _refreshData, child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.resultHistory.length,
                      itemBuilder: (context, index) {
                        return Padding(padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, RESULT_PAGE, arguments: data[index]);
                            },
                            child: HistoryItem(resultHistory: data[index],),
                          ),);
                      },
                    )))
              ],
            );
          }
          return const Center(child: Text('Belum ada data history',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: kRichBlack,
            fontSize: 24
          ),),);
        } else if (state is ErrorResultHistoryState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message, style:
              const TextStyle(fontFamily: 'Poppins'),), behavior: SnackBarBehavior.floating, duration: const Duration(seconds: 3),)
          );
        }
        return Container();
      }),
    );
  }
}
