import 'package:flutter/material.dart';

import '../../data/models/completedhomework.dart';
import './completedHomeworkItemLayer.dart';

class CompletedHomeworkSessionLayer extends StatelessWidget {
  final int sessionNumber;
  final Map<String, CompletedHomework> completedHomeworkTypeSessions;

  CompletedHomeworkSessionLayer({
    required this.sessionNumber,
    required this.completedHomeworkTypeSessions,
  });
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("Session ${sessionNumber + 1}"),
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: completedHomeworkTypeSessions.entries.length,
          separatorBuilder: (_, index) => SizedBox(),
          itemBuilder: (_, index) => CompletedHomeworkItemLayer(
            completedHomework: completedHomeworkTypeSessions.values
                .toList()
                .reversed
                .toList()[index],
          ),
        )
      ],
    );
  }
}
