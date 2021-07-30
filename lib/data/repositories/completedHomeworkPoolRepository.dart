import 'package:cloud_firestore/cloud_firestore.dart';

import '../dataProviders/completedHomeworkPoolDataProvider.dart';
import '../models/completedhomework.dart';
import '../models/completedhomeworkpool.dart';

class CompletedHomeworkPoolRepository {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;
  final String clientId;

  late CompletedHomeworkPoolDataProvider completedHomeworkPoolDataProvider;

  CompletedHomeworkPoolRepository({
    required this.firestoreInstance,
    required this.clientId,
    required this.therapistId,
  }) {
    completedHomeworkPoolDataProvider = CompletedHomeworkPoolDataProvider(
      firestoreInstance: firestoreInstance,
      therapistId: therapistId,
      clientId: clientId,
    );
  }

  Future<CompletedHomeworkPool> getCompletedHomeworkPool() async {
    QuerySnapshot rawCompletedHomeworkPool =
        await completedHomeworkPoolDataProvider.getRawCompletedHomeworkPool();

    CompletedHomeworkPool completedHomeworkPool = new CompletedHomeworkPool();

    rawCompletedHomeworkPool.docs.forEach((rawCompletedomework) {
      String completedHomeworkTitle = rawCompletedomework.data()["title"];
      int sessionNumberOfCompletion =
          rawCompletedomework.data()["sessionNumberOfCompletion"];

      final CompletedHomework newCompletedHomework = CompletedHomework(
        id: rawCompletedomework.id,
        referencedAssignedHomeworkId:
            rawCompletedomework.data()["referencedAssignedHomeworkId"],
        title: rawCompletedomework.data()["title"],
        sessionNumberOfCompletion: sessionNumberOfCompletion,
        fields: rawCompletedomework.data()["fields"],
        answers: rawCompletedomework.data()["answers"],
        dateTimeAnswered:
            rawCompletedomework.data()["dateTimeAnswered"].toDate(),
      );

      completedHomeworkPool.data.update(
        completedHomeworkTitle,
        (value) => {
          ...value,
          sessionNumberOfCompletion: value.update(
            sessionNumberOfCompletion,
            (value) => {
              ...value,
              rawCompletedomework.id: newCompletedHomework,
            },
            ifAbsent: () => {rawCompletedomework.id: newCompletedHomework},
          )
        },
        ifAbsent: () => {
          sessionNumberOfCompletion: {
            rawCompletedomework.id: newCompletedHomework
          }
        },
      );
    });

    return completedHomeworkPool;
  }

  Future<void> submitCompletedHomework(
      {required CompletedHomework completedHomework}) async {
    await completedHomeworkPoolDataProvider.submitCompletedHomeworkInDatabase(
        completedHomework: completedHomework);
  }

  Future<void> updateCompleteHomework({
    required String completedHomeworkId,
    required Map<String, String> updatedAnswers,
  }) async {
    await completedHomeworkPoolDataProvider.updateCompletedHomeworkInDatabase(
      completedHomeworkId: completedHomeworkId,
      updatedAnswers: updatedAnswers,
    );
  }

  Future<void> deleteCompletedHomework(
      {required String completedHomeworkId}) async {
    await completedHomeworkPoolDataProvider.deleteCompletedHomework(
        completedHomeworkId: completedHomeworkId);
  }
}
