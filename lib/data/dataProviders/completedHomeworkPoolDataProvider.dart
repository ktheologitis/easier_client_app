import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/completedhomework.dart';

class CompletedHomeworkPoolDataProvider {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;
  final String clientId;

  CompletedHomeworkPoolDataProvider({
    required this.firestoreInstance,
    required this.therapistId,
    required this.clientId,
  });

  Future<QuerySnapshot> getRawCompletedHomeworkPool() async {
    QuerySnapshot rawCompletedHomeworkPool = await firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(clientId)
        .collection("completedHomework")
        .orderBy("dateTimeAnswered", descending: false)
        .get();

    return rawCompletedHomeworkPool;
  }

  Future<void> submitCompletedHomeworkInDatabase(
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
      "sessionNumberOfCompletion": completedHomework.sessionNumberOfCompletion,
      "dateTimeAnswered":
          Timestamp.fromDate(completedHomework.dateTimeAnswered),
    });
  }

  Future<void> updateCompletedHomeworkInDatabase(
      {required String completedHomeworkId,
      required Map<String, String> updatedAnswers}) async {
    firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(clientId)
        .collection("completedHomework")
        .doc(completedHomeworkId)
        .update({
      ...updatedAnswers,
    });
  }

  Future<void> deleteCompletedHomework(
      {required String completedHomeworkId}) async {
    await firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(clientId)
        .collection("completedHomework")
        .doc(completedHomeworkId)
        .delete();
  }
}
