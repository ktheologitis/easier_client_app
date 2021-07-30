import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easier_client_app/logic/firestoreinstancecubit/firestoreinstancecubit.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/completedhomework.dart';

class AnswerHomeworkDataProvider {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;
  final String clientId;
  AnswerHomeworkDataProvider({
    required this.firestoreInstance,
    required this.therapistId,
    required this.clientId,
  });

  Future<void> submitCompletedHomework(
      {required CompletedHomework completedHomework}) async {
    firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(clientId)
        .collection("completedHomework")
        .doc(completedHomework.id)
        .set({
      "id": completedHomework.id,
      "referencedAssignedHomeworkId":
          completedHomework.referencedAssignedHomeworkId,
      "title": completedHomework.title,
      "fields": completedHomework.fields,
      "answers": completedHomework.answers,
      "datetIimeAnswered":
          Timestamp.fromDate(completedHomework.dateTimeAnswered),
    });
  }
}
