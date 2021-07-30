import 'package:easier_client_app/data/models/completedhomework.dart';
import 'package:flutter/material.dart';

import '../../logic/answerHomeworkBloc/answerHomeworkBarrel.dart';
import '../components/bottomAppBar.dart';

class FieldAnswerScreenArguments {
  final String fieldName;
  final AnswerHomeworkBloc answerHomeworkBloc;

  FieldAnswerScreenArguments({
    required this.fieldName,
    required this.answerHomeworkBloc,
  });
}

enum Mode {
  newHomework,
  existingHomework,
}

class FieldAnswerScreen extends StatelessWidget {
  static String routeName = "FieldAnswerScreen";
  final TextEditingController _fieldController = TextEditingController();

  FieldAnswerScreen();
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final FieldAnswerScreenArguments args = ModalRoute.of(context)!
        .settings
        .arguments as FieldAnswerScreenArguments;
    if (_fieldController.text.isEmpty) {
      _fieldController.text = args
          .answerHomeworkBloc.state.completedHomework.answers[args.fieldName];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: statusBarHeight,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 56,
              child: Container(
                // color: Colors.red,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back)),
                    SizedBox(
                      width: 24.0,
                    ),
                    Text(
                      args.fieldName,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 16.0,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Container(
              // color: Colors.amber,
              child: TextField(
                  controller: _fieldController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Write your answer here..."),
                  maxLines: 7),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          print(
              "session number of completion: ${args.answerHomeworkBloc.state.completedHomework.sessionNumberOfCompletion}");
          args.answerHomeworkBloc.state.completedHomework
              .answers[args.fieldName] = _fieldController.text;
          final CompletedHomework updatedCompletedHomework =
              CompletedHomework.cloneOf(
            args.answerHomeworkBloc.state.completedHomework,
            dateTime: DateTime.now(),
          );
          args.answerHomeworkBloc.add(AnswerHomeworkUpdated(
              completedHomework: updatedCompletedHomework));
          Navigator.of(context).pop();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
