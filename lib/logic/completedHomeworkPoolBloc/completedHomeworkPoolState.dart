import 'package:easier_client_app/data/models/completedhomeworkpool.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/completedhomeworkpool.dart';

class CompletedHomeworkPoolState {
  final CompletedHomeworkPool completedHomeworkPool;
  CompletedHomeworkPoolState({required this.completedHomeworkPool});
}

class CompletedHomeworkPoolInit extends CompletedHomeworkPoolState {
  CompletedHomeworkPoolInit(
      {required CompletedHomeworkPool completedHomeworkPool})
      : super(completedHomeworkPool: completedHomeworkPool);
}

class CompletedHomeworkPoolSyncedWithDatabase
    extends CompletedHomeworkPoolState {
  CompletedHomeworkPoolSyncedWithDatabase(
      {required CompletedHomeworkPool completedHomeworkPool})
      : super(completedHomeworkPool: completedHomeworkPool);
}
