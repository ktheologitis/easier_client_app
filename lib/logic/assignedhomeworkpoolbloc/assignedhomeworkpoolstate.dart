import '../../data/models/assignedhomeworkpool.dart';

class AssignedHomeworkPoolState {
  final AssignedHomeworkPool assignedHomeworkPool;
  AssignedHomeworkPoolState({required this.assignedHomeworkPool});
}

class AssignedHomeworkPoolInit extends AssignedHomeworkPoolState {
  AssignedHomeworkPoolInit({required AssignedHomeworkPool assignedHomeworkPool})
      : super(assignedHomeworkPool: assignedHomeworkPool);
}

class AssignedHomeworkPoolDataSyncedWithDatabase
    extends AssignedHomeworkPoolState {
  AssignedHomeworkPoolDataSyncedWithDatabase(
      {required AssignedHomeworkPool assignedHomeworkPool})
      : super(assignedHomeworkPool: assignedHomeworkPool);
}
