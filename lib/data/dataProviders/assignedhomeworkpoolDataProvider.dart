import 'package:cloud_firestore/cloud_firestore.dart';

class AssignedHomeworkPoolDataProvider {
  final String therapistId;
  final String clientId;
  final FirebaseFirestore firestoreInstance;

  AssignedHomeworkPoolDataProvider({
    required this.therapistId,
    required this.clientId,
    required this.firestoreInstance,
  });

  Future<QuerySnapshot> getRawAssignedHomework() async {
    QuerySnapshot rawAssignedHomework = await firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("clients")
        .doc(clientId)
        .collection("assignedHomework")
        .get();

    return rawAssignedHomework;
  }

  Future<QuerySnapshot> getRawReferencedHomework(
      {required List<String> referencedHomeworkIds}) async {
    QuerySnapshot rawReferencedHomework = await firestoreInstance
        .collection("therapists")
        .doc(therapistId)
        .collection("homeworkPool")
        .where("id", whereIn: referencedHomeworkIds)
        .get();

    return rawReferencedHomework;
  }
}
