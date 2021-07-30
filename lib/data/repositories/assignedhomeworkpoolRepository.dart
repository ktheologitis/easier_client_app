import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/assignedhomeworkpool.dart';
import '../models/assignedhomework.dart';
import '../models/homeworkpool.dart';
import '../models/homework.dart';
import '../dataProviders/assignedhomeworkpoolDataProvider.dart';

class AssignedHomeworkPoolRepository {
  final String therapistId;
  final String clientId;
  final FirebaseFirestore firestoreInstance;

  late AssignedHomeworkPoolDataProvider assignedHomeworkPoolDataProvider;

  AssignedHomeworkPoolRepository({
    required this.clientId,
    required this.therapistId,
    required this.firestoreInstance,
  }) {
    assignedHomeworkPoolDataProvider = AssignedHomeworkPoolDataProvider(
      therapistId: therapistId,
      clientId: clientId,
      firestoreInstance: firestoreInstance,
    );
  }

  Future<AssignedHomeworkPool> getAssignedHomework() async {
    QuerySnapshot rawAssignedHomework =
        await assignedHomeworkPoolDataProvider.getRawAssignedHomework();

    List<String> referencedHomeworkIds =
        rawAssignedHomework.docs.map((rawAssignedHomework) {
      return rawAssignedHomework.data()["referencedHomeworkId"] as String;
    }).toList();

    QuerySnapshot rawReferencedHomeworkPool =
        await assignedHomeworkPoolDataProvider.getRawReferencedHomework(
            referencedHomeworkIds: referencedHomeworkIds);

    HomeworkPool referencedHomeworkPool = new HomeworkPool();

    rawReferencedHomeworkPool.docs.forEach((referencedHomework) {
      referencedHomeworkPool.data[referencedHomework.id] = new Homework(
        id: referencedHomework.id,
        title: referencedHomework.data()["title"],
        fields: referencedHomework.data()["fields"],
        dateCreated: referencedHomework.data()["dateCreated"].toDate(),
      );
    });

    AssignedHomeworkPool assignedHomeworkPool = AssignedHomeworkPool();

    rawAssignedHomework.docs.forEach((rawAssignedHomework) {
      assignedHomeworkPool.data[rawAssignedHomework.id] =
          AssignedHomework.fromCloud(
              id: rawAssignedHomework.id,
              referencedHomeworkId:
                  rawAssignedHomework.data()["referencedHomeworkId"],
              note: rawAssignedHomework.data()["note"],
              homeworkPool: referencedHomeworkPool);
    });

    return assignedHomeworkPool;
  }
}
