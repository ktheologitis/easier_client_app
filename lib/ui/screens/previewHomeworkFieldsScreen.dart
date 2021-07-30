import 'package:easier_client_app/data/models/completedhomework.dart';
import 'package:easier_client_app/logic/answerHomeworkBloc/answerHomeworkBarrel.dart';
import 'package:easier_client_app/logic/completedHomeworkPoolBloc/completedHomeworkPoolBarrel.dart';
import 'package:easier_client_app/ui/components/assignedHomeworkListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/assignedhomework.dart';
import '../components/bottomAppBar.dart';
import '../components/homeworkFieldItem.dart';

class PreviewHomeworkFieldsScreen extends StatelessWidget {
  static String routeName = "previewHomeworFieldskScreen";

  bool allFieldsAnswered(CompletedHomework completedHomework) {
    return completedHomework.answers.values
        .every((element) => element.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final PreviewHomeworkFieldsScreenArgumemnts args = ModalRoute.of(context)!
        .settings
        .arguments as PreviewHomeworkFieldsScreenArgumemnts;
    final AnswerHomeworkBloc answerHomeworkBloc = args.answerHomeworkBloc;
    final AssignedHomework assignedHomework = args.assignedHomework;
    final CompletedHomeworkPoolBloc completedHomeworkPoolBloc =
        BlocProvider.of<CompletedHomeworkPoolBloc>(context);

    return BlocListener<AnswerHomeworkBloc, AnswerHomeworkState>(
      bloc: answerHomeworkBloc,
      listener: (_, state) {
        if (state is AnswerHomeworkFinish) {
          completedHomeworkPoolBloc.add(CompletedHomeworkSubmitted(
            completedHomework: state.completedHomework,
            answerHomeworkBloc: answerHomeworkBloc,
          ));
          Navigator.of(context).pop();
        }
      },
      child: BlocProvider.value(
        value: answerHomeworkBloc,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SizedBox(
                height: statusBarHeight,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "${assignedHomework.title}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                // answerHomeworkBloc.add(AnswerHomeworkCanceled(
                                //   completedHomework:
                                //       answerHomeworkBloc.state.completedHomework,
                                // ));
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.clear,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ListView.separated(
                            itemCount: assignedHomework.fields.length,
                            separatorBuilder: (_, index) => SizedBox(
                              height: 8,
                            ),
                            itemBuilder: (_, index) => PreviewHomeworkFieldItem(
                              assignedHomework: assignedHomework,
                              index: index,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          floatingActionButton:
              allFieldsAnswered(answerHomeworkBloc.state.completedHomework)
                  ? FloatingActionButton(
                      child: Icon(Icons.done),
                      onPressed: () {
                        answerHomeworkBloc.add(AnswerHomeworkSubmitted(
                            completedHomework:
                                answerHomeworkBloc.state.completedHomework));
                      },
                    )
                  : null,
          floatingActionButtonLocation:
              allFieldsAnswered(answerHomeworkBloc.state.completedHomework)
                  ? FloatingActionButtonLocation.centerDocked
                  : null,
          bottomNavigationBar: MyBottomAppBar(),
        ),
      ),
    );
  }
}
