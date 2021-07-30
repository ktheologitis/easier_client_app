import 'package:flutter/material.dart';

import '../../data/models/completedhomework.dart';
import './completedHomeworkSessionLayer.dart';

class CompletedHomeworkTypeLayer extends StatelessWidget {
  final String completedHomeworkTitle;
  final Map<int, Map<String, CompletedHomework>> completedHomeworkTypes;

  CompletedHomeworkTypeLayer({
    required this.completedHomeworkTitle,
    required this.completedHomeworkTypes,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text("$completedHomeworkTitle"),
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemCount: completedHomeworkTypes.entries.length,
            separatorBuilder: (context, index) => SizedBox(),
            itemBuilder: (context, index) => CompletedHomeworkSessionLayer(
              sessionNumber: completedHomeworkTypes.keys.toList()[index],
              completedHomeworkTypeSessions:
                  completedHomeworkTypes.values.toList()[index],
            ),
          ),
        ],
      ),
    );
  }
}
