import 'package:core/models/result_history.dart';
import 'package:core/notifier/score_model.dart';
import 'package:core/style/colors.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultPage extends StatefulWidget {
  final Object? resultHistory;

  const ResultPage(this.resultHistory, {super.key});

  @override
  State<StatefulWidget> createState() => _ResultPage();
}

class _ResultPage extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final scoreModel = Provider.of<ScoreModel>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Score :',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: kRichBlack,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.resultHistory != null
                      ? (widget.resultHistory! as ResultHistory)
                          .score
                          .toString()
                      : scoreModel.getMeanHipotetik().toString(),
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 48,
                      color: scoreModel.getMeanHipotetik() > 1.5
                          ? Colors.redAccent
                          : scoreModel.getMeanHipotetik() == 1.5
                              ? kMikadoYellow
                              : Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        const TextSpan(
                            text: 'Klasifikasi: ',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.grey)),
                        TextSpan(
                            text: widget.resultHistory != null
                                ? (widget.resultHistory! as ResultHistory)
                                    .classification
                                    .toString()
                                : scoreModel.getClassification(),
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: kRichBlack,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ]),
                ),
                const SizedBox(
                  height: 48,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Saran: ',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Column(
                        children: List.generate(
                          scoreModel.getMeanHipotetik() > 1.5
                              ? educations[2].length
                              : scoreModel.getMeanHipotetik() == 1.5
                              ? educations[1].length
                              : educations[0].length,
                              (index) {
                            String educationText =
                            scoreModel.getMeanHipotetik() > 1.5
                                ? educations[2][index]
                                : scoreModel.getMeanHipotetik() == 1.5
                                ? educations[1][index]
                                : educations[0][index];

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}.",
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: kRichBlack,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Text(
                                    educationText,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: kRichBlack,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
