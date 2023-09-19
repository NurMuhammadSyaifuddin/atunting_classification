import 'package:core/models/inspection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifier/answer_model.dart';
import '../../notifier/score_model.dart';
import '../../style/colors.dart';

class QuestionItem extends StatefulWidget {
  Inspection inspection;
  int indexList;

  QuestionItem({super.key, required this.inspection, required this.indexList});

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {

  @override
  Widget build(BuildContext context) {

    final scoreModel = Provider.of<ScoreModel>(context);

    return Consumer<AnswerModel>(builder: (context, model, _) {
      return Column(
        children: [
           Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '${widget.indexList+1}. ${widget.inspection.question}',
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: kRichBlack,
                    fontSize: 14),
              ),
            ),
          ),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 1,
            childAspectRatio: 8,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: List.generate(widget.inspection.answer.length, (index) {
              return Container(padding: EdgeInsets.zero, child: RadioListTile(
                title: Text(
                  widget.inspection.answer[index],
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: kRichBlack,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.visible,
                ),
                value: index + 1,
                groupValue: model.currentRadio[widget.indexList],
                onChanged: (value) {
                  model.setCurrentRadio(value!, widget.indexList);
                  scoreModel.addSelectedItem(value);
                  if (widget.inspection.answer.length == 2){
                    if (value == 1){
                      scoreModel.addOrUpdateScore(widget.indexList, 0);
                    } else {
                      scoreModel.addOrUpdateScore(widget.indexList, 2);
                    }
                  } else {
                    if (value == 1){
                      scoreModel.addOrUpdateScore(widget.indexList, 0);
                    } else if (value == 2){
                      scoreModel.addOrUpdateScore(widget.indexList, 1);
                    } else {
                      scoreModel.addOrUpdateScore(widget.indexList, 2);
                    }
                  }
                },
              ),);
            }),
          ),
          const SizedBox(height: 8,),
          const Divider(
            color: kRichBlack,
          )
        ],
      );
    });
  }


}
