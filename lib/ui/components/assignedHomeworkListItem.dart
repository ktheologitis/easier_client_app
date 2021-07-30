import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/answerHomeworkBloc/answerHomeworkBloc.dart';
import '../../data/models/assignedhomework.dart';
import '../../data/models/assignedhomeworkpool.dart';
import '../components/showNoteDialog.dart';
import '../screens/previewHomeworkFieldsScreen.dart';

class PreviewHomeworkFieldsScreenArgumemnts {
  final AnswerHomeworkBloc answerHomeworkBloc;
  final AssignedHomework assignedHomework;

  PreviewHomeworkFieldsScreenArgumemnts({
    required this.answerHomeworkBloc,
    required this.assignedHomework,
  });
}

class AssignedHomeworkListItem extends StatelessWidget {
  AssignedHomeworkListItem({
    required this.assignedHomework,
    required this.assignedHomeworkPool,
  });

  final AssignedHomework assignedHomework;
  final AssignedHomeworkPool assignedHomeworkPool;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final AnswerHomeworkBloc answerHomeworkBloc =
        BlocProvider.of<AnswerHomeworkBloc>(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(PreviewHomeworkFieldsScreen.routeName,
              arguments: PreviewHomeworkFieldsScreenArgumemnts(
                answerHomeworkBloc: answerHomeworkBloc,
                assignedHomework: assignedHomework,
              ));
        },
        child: SizedBox(
          height: 56,
          width: width - 32,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.14),
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 1.0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  offset: Offset(0.0, 2.0), //(x,y)
                  blurRadius: 1.0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: Material(
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(width: 16.0),
                  Text(
                    assignedHomework.title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      showNoteDialog(
                        context: context,
                        homeworkTitle: assignedHomework.title,
                        note: assignedHomework.note,
                      );
                    },
                    icon: Icon(Icons.note),
                  ),
                  SizedBox(width: 16.0),
                  IconButton(
                    onPressed: () {
                      print("do homework");
                    },
                    icon: Icon(Icons.rate_review),
                  ),
                  SizedBox(width: 16.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
