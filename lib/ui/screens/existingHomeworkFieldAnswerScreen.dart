import 'package:flutter/material.dart';

import '../../data/models/completedhomework.dart';
import '../../logic/completedHomeworkPoolBloc/completedHomeworkPoolBarrel.dart';
import '../components/bottomAppBar.dart';

class ExistingHomeworkFieldAnswerScreenArguments {
  final String fieldName;
  final CompletedHomework completedHomework;
  final CompletedHomeworkPoolBloc completedHomeworkPoolBloc;

  ExistingHomeworkFieldAnswerScreenArguments({
    required this.fieldName,
    required this.completedHomework,
    required this.completedHomeworkPoolBloc,
  });
}

class ExistingHomeworkFieldAnswerScreen extends StatefulWidget {
  static String routeName = "ExistingHomeworkFieldAnswerScreen";

  @override
  _ExistingHomeworkFieldAnswerScreenState createState() =>
      _ExistingHomeworkFieldAnswerScreenState();
}

class _ExistingHomeworkFieldAnswerScreenState
    extends State<ExistingHomeworkFieldAnswerScreen> {
  final TextEditingController _fieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      final ExistingHomeworkFieldAnswerScreenArguments args =
          ModalRoute.of(context)!.settings.arguments
              as ExistingHomeworkFieldAnswerScreenArguments;
      _fieldController.text = args.completedHomework.answers[args.fieldName];
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    final ExistingHomeworkFieldAnswerScreenArguments args =
        ModalRoute.of(context)!.settings.arguments
            as ExistingHomeworkFieldAnswerScreenArguments;

    return Scaffold(
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
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Container(
              // color: Colors.amber,
              child: TextField(
                  controller: _fieldController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "You cannot give an empty answer..."),
                  maxLines: 7),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          if (args.completedHomework.answers[args.fieldName] !=
              _fieldController.text) {
            final CompletedHomework updatedCompletedHomework =
                CompletedHomework.cloneOf(
              args.completedHomework,
              dateTime: args.completedHomework.dateTimeAnswered,
            );
            updatedCompletedHomework.answers[args.fieldName] =
                _fieldController.text;
            args.completedHomeworkPoolBloc.add(CompletedHomeworkUpdated(
                completedHomework: updatedCompletedHomework));
          }
          Navigator.of(context).pop();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
