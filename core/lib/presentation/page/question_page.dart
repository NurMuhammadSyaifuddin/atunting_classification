import 'package:core/core.dart';
import 'package:core/models/result_history.dart';
import 'package:core/notifier/result_history_provider.dart';
import 'package:core/notifier/score_model.dart';
import 'package:core/presentation/bloc/inspection/inspection_bloc.dart';
import 'package:core/presentation/bloc/inspection/inspection_state.dart';
import 'package:core/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/inspection/inspection_event.dart';
import 'package:provider/provider.dart';
import '../screen/question_item.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<StatefulWidget> createState() => _QuestionPage();
}

class _QuestionPage extends State<QuestionPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetInspectionBloc>(context).add(GetInspectionEvent());
  }

  Future<void> _refreshData() async {
    BlocProvider.of<GetInspectionBloc>(context).add(GetInspectionEvent());
  }

  @override
  Widget build(BuildContext context) {
    final scoreModel = Provider.of<ScoreModel>(context);
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(onRefresh: _refreshData, child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 24,),
              BlocBuilder<GetInspectionBloc, InspectionState>(
                  builder: (context, state) {
                    if (state is LoadingInspectionState) {
                      return const Center(child: CircularProgressIndicator(),);
                    } else if (state is LoadedInspectionState) {
                      return ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.inspections.length,
                          itemBuilder: (context, index) {
                            return QuestionItem(
                              inspection: state.inspections[index], indexList: index,
                            );
                          });
                    } else if (state is ErrorInspectionState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message,
                            style: const TextStyle(fontFamily: 'Poppins'),),
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 2),));
                    }
                    return Container();
                  }),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  if (scoreModel.getCountAnswer() == 30) {
                    DateTime now = DateTime.now();
                    ResultHistory resultHistory = ResultHistory(date: getFormattedDate(now), score: scoreModel.getMeanHipotetik(), classification: scoreModel.getClassification());
                    Provider.of<ResultHistoryProvider>(context, listen: false).sendResult(resultHistory, firebaseAuth.currentUser!.email.toString());
                    Navigator.pushReplacementNamed(context, RESULT_PAGE);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Pastikan semua pertanyaan telah terjawab',
                        style: TextStyle(
                            fontFamily: 'Poppins'
                        ),),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 3),));
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Submit",
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
                      Icons.send,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32,)
            ],
          ),
        )),
      ),
    );
  }
}
