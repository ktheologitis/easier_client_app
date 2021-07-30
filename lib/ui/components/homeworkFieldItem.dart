import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/assignedhomework.dart';
import '../../logic/answerHomeworkBloc/answerHomeworkBloc.dart';
import '../screens/fieldAnswerScreen.dart';

class PreviewHomeworkFieldItem extends StatelessWidget {
  PreviewHomeworkFieldItem({
    required this.assignedHomework,
    required this.index,
  });

  final AssignedHomework assignedHomework;
  final int index;

  @override
  Widget build(BuildContext context) {
    final AnswerHomeworkBloc answerHomeworkBloc =
        BlocProvider.of<AnswerHomeworkBloc>(context);
    final String field = assignedHomework.fields[index];

    return Card(
      color: answerHomeworkBloc.state.completedHomework.answers[field].isEmpty
          ? Theme.of(context).primaryColor.withAlpha(60)
          : Theme.of(context).accentColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(FieldAnswerScreen.routeName,
                arguments: FieldAnswerScreenArguments(
                  fieldName: assignedHomework.fields[index],
                  answerHomeworkBloc: answerHomeworkBloc,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16, top: 16, bottom: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${assignedHomework.fields[index]}",
                style: answerHomeworkBloc
                        .state.completedHomework.answers[field].isEmpty
                    ? Theme.of(context).textTheme.subtitle1
                    : TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 16,
      borderOnForeground: true,
      shadowColor: Colors.grey[200],
    );
  }
}
