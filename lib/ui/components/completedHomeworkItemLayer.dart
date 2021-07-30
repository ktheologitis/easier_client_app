import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/models/completedhomework.dart';
import '../../logic/completedHomeworkPoolBloc/completedHomeworkPoolBarrel.dart';
import '../screens/reviewExistingCompletedHomeworkScreen.dart';

class CompletedHomeworkItemLayer extends StatelessWidget {
  final CompletedHomework completedHomework;

  CompletedHomeworkItemLayer({required this.completedHomework});

  @override
  Widget build(BuildContext context) {
    final CompletedHomeworkPoolBloc completedHomeworkPoolBloc =
        BlocProvider.of<CompletedHomeworkPoolBloc>(context);
    final String formattedDate =
        DateFormat.yMMMMd().format(completedHomework.dateTimeAnswered);
    final String formattedTime =
        DateFormat.Hm().format(completedHomework.dateTimeAnswered);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ReviewExistingCompletedHomeworkScreen.routeName,
                arguments: ReviewExistingCompletedHomeworkScreenArguments(
                  homeworkDateTimeTitle: "$formattedDate - $formattedTime",
                  completedHomework: completedHomework,
                  completedHomeworkPoolBloc: completedHomeworkPoolBloc,
                ));
      },
      child: ListTile(
        leading: SizedBox(
          height: 40,
          width: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.rate_review_outlined,
              color: Colors.white,
            ),
          ),
        ),
        title: Text("$formattedDate - $formattedTime"),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            completedHomeworkPoolBloc.add(
                CompletedHomeworkDeleted(completedHomework: completedHomework));
          },
        ),
      ),
    );
  }
}
